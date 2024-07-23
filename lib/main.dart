import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/my_theme.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/pages/continue_shopping.dart';
import 'package:shop_init/src/presentation/views/account/notifications/notification.dart';
import 'package:shop_init/src/core/state_management/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:shop_init/src/core/state_management/bloc/order/order_bloc.dart';
import 'package:shop_init/src/core/state_management/cubits/google_sign_in/google_sign_in_cubit.dart';
import 'package:shop_init/src/core/state_management/bloc/product_info/product_info_bloc.dart';
import 'package:shop_init/src/core/state_management/bloc/seller_info/seller_info_bloc.dart';
import 'package:shop_init/firebase_options.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/account_screen.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/components/account_details.dart';
import 'package:shop_init/src/presentation/views/account/my_orders/my_orders.dart';
import 'package:shop_init/src/presentation/views/auth/sign_in_screen.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/category_screen.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/check_out_screen.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/dashboard_screen.dart';
import 'package:shop_init/src/presentation/views/onboarding/onboard_screen.dart';
import 'src/presentation/views/nav_screen.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
 print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
          
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async{
  await setup();
  final prefs = await SharedPreferences.getInstance();
  final onBoardingFirstTime =  prefs.getBool("isFirstTime") ?? true;
  
  print(onBoardingFirstTime);
  runApp( MyApp(onBoardingFirstTime: onBoardingFirstTime));
}



setup() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xfffff7f1),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xfffff7f1),
    )
  );
  
}


class MyApp extends StatelessWidget {
  final bool onBoardingFirstTime;
   const MyApp({super.key, required this.onBoardingFirstTime});
  

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SellerInfoBloc()),
        BlocProvider(create: (context) => ProductInfoBloc()),
        BlocProvider(create: (context) => AddToCartBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => GoogleSignInCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.light,
        darkTheme: MyTheme.dark,
        themeMode: ThemeMode.light,
        initialRoute: onBoardingFirstTime ? '/onboarding' : '/',   
        
        routes: {
          '/onboarding' : (context) => const OnBoardingScreen(),
          '/' : (context) => firebaseAuth.currentUser != null ? const BottomNavScreen() : const LoginScreen(),
          '/signIn' : (context) => const  LoginScreen(),
          '/dashboard'  : (context) => DashboardScreen(),
          '/category'  : (context) => const CategoryScreen(),
          '/account'  : (context) => const AccountScreen(),
          '/checkout' : (context) => const CheckOutScreen(),
          '/account_details' : (context) => const AccountDetailsScreen(),
          '/myOrders' : (context) => const MyOrdersScreen(),
          '/notification': (context) => const NotificationScreen(),
          '/continueShopping' : (_)=> const ContinueShoppingPart(),
        },
      ),
    );
  }
}

