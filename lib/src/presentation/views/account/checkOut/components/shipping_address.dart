import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_init/src/const/vice_theme.dart';

class ShippingAddress extends StatelessWidget {
  final bool? color;
  const ShippingAddress({super.key, this.color = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return color == true
        ? Container(
            decoration: BoxDecoration(
              color: theme.primaryColorDark,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10.0),
                Text(
                  "Shipping Address",
                  style:
                      AppStyle.titleStyle.copyWith(color: theme.primaryColor),
                ),
                const Gap(10),
                ListTile(
                  leading: Icon(
                    Iconsax.location,
                    size: 24,
                    color: theme.primaryColor,
                  ),
                  title: Text(
                    "Office",
                    style: AppStyle.normalStyle
                        .copyWith(color: theme.primaryColor),
                  ),
                  subtitle: Text(
                    "No.5288, Securelink Co. Ltd.,",
                    style:
                        AppStyle.descStyle.copyWith(color: theme.primaryColor),
                  ),
                  trailing: Icon(
                    Iconsax.edit,
                    size: 24,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: theme.primaryColorLight,
              border: Border.all(width: 1, color: theme.primaryColorDark),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    Iconsax.location,
                    size: 24,
                    color: theme.primaryColorDark,
                  ),
                  title: Text(
                    "Home",
                    style: AppStyle.normalStyle
                        .copyWith(color: theme.primaryColorDark),
                  ),
                  subtitle: Text(
                    "No.55, Between 1A*1B, 65D Street, Mandalay.",
                    style: AppStyle.descStyle
                        .copyWith(color: theme.primaryColorDark),
                  ),
                  trailing: Icon(
                    Icons.radio_button_off,
                    size: 24,
                    color: theme.primaryColorDark,
                  ),
                ),
              ],
            ),
          );
  }
}
