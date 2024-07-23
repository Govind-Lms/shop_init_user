import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_init/src/const/vice_theme.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColorDark,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10.0),
          Text("Shipping Address",style: AppStyle.titleStyle.copyWith(color: theme.primaryColor),),
          const Gap(10),
          ListTile(
            leading:  Icon(Iconsax.location,size: 24,color: theme.primaryColor,),
            title: Text("Home",style: AppStyle.normalStyle.copyWith(color: theme.primaryColor),),
            subtitle: Text("No.5288, Securelink Co. Ltd.,",style: AppStyle.descStyle.copyWith(color: theme.primaryColor),),
            trailing:  Icon(Iconsax.edit,size: 24,color: theme.primaryColor,),
          ),
        ],
      ),
    );
  }
}