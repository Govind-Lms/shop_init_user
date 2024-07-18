import 'package:flutter/material.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';

class CheckoutPart extends StatelessWidget {
  const CheckoutPart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        navName(context, '/checkout');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: kToolbarHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: theme.primaryColorDark
        ),
        child: Center(
          child: Text(
            'Checkout',
            style: ViceStyle.normalStyle.copyWith(color: theme.primaryColorLight),
          ),
        ),
      ),
    );
  }
}
