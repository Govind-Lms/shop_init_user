import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shop_init/src/core/models/cart_model.dart';
import 'package:shop_init/src/core/models/order_model.dart';
import 'package:shop_init/src/core/state_management/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:shop_init/src/core/state_management/bloc/order/order_bloc.dart';
import '../../../../../../main.dart';
import '../../notifications/message.dart';

class OrderConfirmDialog extends StatefulWidget {
  final List<CartModel> cartLists;
  final int total;
  final int totalQty;
  final int orderId;
  const OrderConfirmDialog(
      {super.key,
      required this.cartLists,
      required this.total,
      required this.totalQty,
      required this.orderId});

  @override
  State<OrderConfirmDialog> createState() => _OrderConfirmDialogState();
}

class _OrderConfirmDialogState extends State<OrderConfirmDialog> {
  
  String? _token;
  String? initialMessage;
  List<String> tokens= [];
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
          (value) async {
            accessToken = await generateFCMAccessToken();
            setState(
            () {
              initialMessage = value?.data.toString();
            },
          );
          },
        );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      navName(context, '/myOrders');
    });
  }
  
 
  
  static Future<String> generateFCMAccessToken() async {
    try {
      /* get these details from the file you downloaded(generated)
          from firebase console
      */
      String type = "service_account";
      String projectId = "sho-pinit";
      String privateKeyId = "b1a9cbfa3b763f1d9dc1dd05e288741da54be79b";
      String privateKey =
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDa61zsgoWkpKMu\ng+KtSZa1EP+kpGTsYgH3Im6HuK/bOVsyvYQJJtFs+Mug6kk5enxoJzLCsnAvKgV5\nOkWIHsuHOw2KmsIzkIkGAfdApSyW61fDSR1fdcaLwkAphn6zeOrDDPAY9NTN+3Ny\nQHNfqoj4lZB3X2Bc2jdxbwr7l83DhEU0MpCuzX3qX3r5ZJhhCHNHVyQENvgNk0tw\nqr4agMHKjYpBgrbip5QL6x+9K00SIS+A+gocC90ou95LutYpcblHoXTv1cLxuK0O\naNoqijXmEoj4ai/m3smX6uKaoUhDMB/CSJuJUC4O/q3GQbro/Azt+EzKRoJ5Lf2V\n1iK6fzc7AgMBAAECggEAGO+gSQxg/q0GLWE2a7irIvrJs85J9KcBRE42utztoxH4\ncmIl7Qjv5/K69xxYtORf0VlNreG3Z5fowbNCgkvHsSKn2zbfkhIPmZCVwlZOKu6p\ns4PbhakbsYWx20kHm5fVXdxWaPFSYBgZQVVYDviU24PlzcMebdUpZZFZdekHthJf\n+3X52tigujLJ1J6xOfkAhnyUyFdQ8PZWuQlDBXo8HTzm9RhXTbjV3T18mYuop3yj\ngeZyJ94sgb+B9fnsGf/xxzILoLEyK9xi7zh4PH+qOjXYyYcZLwrMdCfDMOLa8gTl\n5nyprdjWfCEBWRFc4wzyQTmauvR5FpyGHosraZyx+QKBgQD1yHpkDKrBGriOKh4t\niroFo3UR+yTlZXoaDkwe+J4otweNCWjabR/FCPGm0P7DGuWQsL08jBN7EtjWHMyg\nvtP4Q44RIkXNFVpe+qbzHW5rRFhNL9JG4C/A3DmKFaOeGxerf7hgS+DtRNGZARR9\nsLh49aGtdK3CK2ts17RHsOi3JQKBgQDkBQMg+s1CQKpRr89j6956RxTiTT4PxDWZ\nPvq5GfRgPGaJEU4TiDcy+WUFl8Tlw5x/0/oifw1kYsWnDEOP61oZy/GMYYtV4Vso\nMkyI84dyo6U2NxcuzuxeMZ7H/Cij2dfqsjQLjgGbFdhB3Q4IokU/dyAzSoNQ/A1e\nVEI65RiW3wKBgC4lux0n57OkIbzHmazxXCYM38FFh1Lu77MOtiomggOhAfDwMFi6\nnnlvSXgJy5u0ZB/7nzxMDKhSDJZ/B8iyq7f0bys2ZSaxeKtWopwJDZ9kULQFY5Td\nKPosHz2W/IaGDbasn2CtPokuH7B7rG5BDRHhBL89phZL8rqX8Yh4ZellAoGAHqqF\n5zOT02s6/M12SOv5+dwBdQYKaLhstPWBZs+UzDSTXa/UHlBdjB96dKwasQQD0jVC\nGM2ZkXyvNG4zz/FJJtsE22prANvUFK3fGTQXbVWQ7J+wIH130Js/zYmeNZsgrNHW\nqg8pLCBd+02ti3+3bHeq/vrwej3L1nnihmU1T2UCgYBaifUgpCsTTz/0m7R3Dl09\nlCYwtQPDEodIMyi0QD24PpRBHwb8XekqbZtf07FDmdtBCXWv8a8VdctHPqqmxHEz\nN1lGJHPBa+S/SyYmGKrZ0yRw8l6C1ss9ikeVL/SOaA2w5ibpdcbM8MzMG+/pyiAR\n3Vz481WXLjMVtvEXHqmmZA==\n-----END PRIVATE KEY-----\n";
      String clientEmail =
          "firebase-adminsdk-zmfop@sho-pinit.iam.gserviceaccount.com";
      String clientId = "100577609957653481302";
      String authUri = "https://accounts.google.com/o/oauth2/auth";
      String tokenUri = "https://oauth2.googleapis.com/token";
      String authProviderX509CertUrl =
          "https://www.googleapis.com/oauth2/v1/certs";
      String clientX509CertUrl =
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-zmfop%40sho-pinit.iam.gserviceaccount.com";
      String universeDomain = "googleapis.com";

      final credentials = ServiceAccountCredentials.fromJson({
        "type": type,
        "project_id": projectId,
        "private_key_id": privateKeyId,
        "client_email": clientEmail,
        "private_key": privateKey,
        "client_id": clientId,
        "auth_uri": authUri,
        "token_uri": tokenUri,
        "auth_provider_x509_cert_url": authProviderX509CertUrl,
        "client_x509_cert_url": clientX509CertUrl,
        "universe_domain": universeDomain
      });

      List<String> scopes = [
        "https://www.googleapis.com/auth/firebase.messaging"
      ];

      final client = await obtainAccessCredentialsViaServiceAccount(
          credentials, scopes, http.Client());
      final accessToken = client;
      Timer.periodic(const Duration(minutes: 59), (timer) {
        accessToken.refreshToken;
      });
      return accessToken.accessToken.data;
    } catch (e) {
      print("THis is the error: $e");
    }
    return "";
  }


  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body:jsonEncode({
          "message": {
            "token": tokens[0],
            "notification": {
              "title": "Order Placed",
              "body": "A new order has been placed with order no. ${widget.orderId}"
            },
            "data": {"story_id": "${widget.orderId}"},
            "android": {
              "notification": {"click_action": "new order placed"}
            },
          }
        }),
      );
      print("Response ${response.statusCode}");
      print("Response ${response.body}");
    } catch (e) {
      print(e);
    }
  }

  saveToFirestore(String? token) async {
    final id = firebaseAuth.currentUser?.uid.toString().replaceRange(0, 20, "0");
    await tokenRef.doc(firebaseAuth.currentUser?.uid).collection("tokens").doc(id).set({"token": token});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            const Gap(20.0),
            Text(
              'Confirm Order'.toUpperCase(),
              style: AccountStyle.nameStyle,
            ),
            const Gap(20.0),
           
            TokenMonitor((token) {
              _token = token;
              return token == null
                  ? const CircularProgressIndicator()
                  : Container();
            }),
            
            Text(
              'You are going to place an order?',
              style: AccountStyle.emailStyle,
            ),
            const Gap(20.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () async{
                    navPop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: kToolbarHeight,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: AccountStyle.logoutStyle
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context, builder: (context){
                      // Future.delayed(const Duration(seconds: 5), () {
                      //   navNameReplacement(context, '/continueShopping');
                      // });
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: Container(
                              width: 200.0,
                              height: 200.0,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: theme.primaryColorDark),
                              child: const Center(child: CircularProgressIndicator(color: Colors.white,),),
                            ),
                          ),
                        );
                      },
                    );
                    
                    
                    ///order placed in firebase
                    OrderModel orderModel = OrderModel(
                        totalAmt: widget.total,
                        totalQty: widget.totalQty,
                        approve: 'pending',
                        id: widget.orderId.toString(),
                        timestamp: Timestamp.now(),
                        uid: firebaseAuth.currentUser!.uid,
                      );

                    BlocProvider.of<OrderBloc>(context).add(AddOrder(orderModel));

                    await orderListRef
                      .doc(widget.orderId.toString())
                      .set({
                        'uid': firebaseAuth.currentUser?.uid,
                        'id': orderModel.id,
                        'timestamp': orderModel.timestamp ?? '',
                        'total' : orderModel.totalAmt,
                        'totalQty' : orderModel.totalQty,
                        'approve': orderModel.approve,
                    });
                  
                    for (int i = 0; i < widget.cartLists.length; i++) {

                      ///getting stocks info of the product
                      final stockData = await itemRef
                        .doc('products')
                        .collection(widget.cartLists[i].category)
                        .doc(widget.cartLists[i].id)
                        .get();
                      final stocks = stockData.get('stocks');
                      print(stocks);

                      ///update stocks in the productRef
                      await itemRef
                        .doc('products')
                        .collection(widget.cartLists[i].category)
                        .doc(widget.cartLists[i].id)
                        .update({
                          'stocks' : widget.cartLists[i].stocks - widget.cartLists[i].quantity
                      });

                      ///update stocks from the wishlists
                      // await bannerRef.doc(widget.cartLists[i].id).update({
                      //   'stocks' : widget.cartLists[i].stocks - widget.cartLists[i].quantity
                      // });

                      ///adding to the user_orders_lists_ref
                      await orderRef
                          .doc(firebaseAuth.currentUser?.uid)
                          .collection("orders")
                          .doc(widget.orderId.toString())
                          .collection('items')
                          .doc(widget.cartLists[i].id)
                          .set({
                        'id': widget.cartLists[i].id,
                        'name': widget.cartLists[i].name,
                        'quantity': widget.cartLists[i].quantity,
                        'price': widget.cartLists[i].price,
                        'category': widget.cartLists[i].category,
                        'stocks': widget.cartLists[i].stocks - widget.cartLists[i].quantity,
                        'color': widget.cartLists[i].color,
                        'size': widget.cartLists[i].size,
                        'imageUrl': widget.cartLists[i].imageUrl,
                        'totalPrice': widget.cartLists[i].totalPrice,
                        'timestamp': widget.cartLists[i].timestamp,
                      });

                      ///adding to the order_lists_ref
                      await orderListRef
                          .doc(widget.orderId.toString())
                          .collection('items')
                          .doc(widget.cartLists[i].id)
                          .set({
                        'id': widget.cartLists[i].id,
                        'name': widget.cartLists[i].name,
                        'quantity': widget.cartLists[i].quantity,
                        'price': widget.cartLists[i].price,
                        'category': widget.cartLists[i].category,
                        'stocks': widget.cartLists[i].stocks - widget.cartLists[i].quantity,
                        'color': widget.cartLists[i].color,
                        'size': widget.cartLists[i].size,
                        'imageUrl': widget.cartLists[i].imageUrl,
                        'totalPrice': widget.cartLists[i].totalPrice,
                        'timestamp': widget.cartLists[i].timestamp,
                      });

                      ///setting orderLength to calculate most buy product
                     
                      // await orderLengthRef
                      //     .doc(widget.cartLists[i].id)
                      //     .collection("orderLength")
                      //     .doc(widget.orderId.toString())
                      //     .set({
                      //   'id': widget.orderId,
                      // });

                      context.read<AddToCartBloc>()
                        .add(RemoveFromCartEvent(
                          productModel: widget.cartLists[i]
                        ),
                      );
                    }

                    ///notification sending...

                    //getting admin tokens
                    final data = await tokenRef.get();
                    print("Length :  ${data.docs.length}");
                    for(int i =0;i<data.docs.length; i++){
                      tokens.add(data.docs[i].get('token'));
                    }

                    saveToFirestore(_token);
                    sendPushMessage();

                    

                    navName(context, '/continueShopping');

                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: kToolbarHeight,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColorDark,
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: AccountStyle.logoutStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}