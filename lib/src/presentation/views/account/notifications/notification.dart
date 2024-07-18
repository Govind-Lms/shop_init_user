import 'package:flutter/material.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
                isAnimated: false,
                showSearchBar: false,
                showDefinedName: true,
                showCart: false,
                name: 'My Cart',
                showBack: true,
            ),
            Center(child: Text("Notifications",style: ViceStyle.titleStyle,),)
          ],
        ),
      ),
    );
  }
}