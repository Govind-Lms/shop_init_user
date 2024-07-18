import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';

class ContinueShoppingPart extends StatelessWidget {
  const ContinueShoppingPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              showCart: false,
              name: "Status",
              showBack: true,
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset("assets/onboarding/shopping.gif"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Order Complete!',
                style: ViceStyle.titleStyle
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                
                navNameReplacement(context, '/');
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Center(
                  child: Text(
                    'View Order',
                    style: ViceStyle.normalStyle
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
