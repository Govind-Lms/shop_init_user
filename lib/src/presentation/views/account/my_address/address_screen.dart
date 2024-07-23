import 'package:flutter/material.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/components/shipping_address.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
          isAnimated: false,
          showSearchBar: false,
          showDefinedName: true,
          name: 'My Address',
          showCart: false,
          showBack: true,
        ),
            ShippingAddress(),
            ShippingAddress(color: false,),
            ShippingAddress(color: false,),
          
          ],
        ),
      ),
    );
  }
}