import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/constant.dart';
class ReceiptDialog extends StatelessWidget {
  final String title;
  final String message;
  const ReceiptDialog(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            const Gap(20.0),
            Text(
              title.toUpperCase(),
              style: AccountStyle.nameStyle,
            ),
            const Gap(20.0),
           
           
            Text(
              message,
              style: AccountStyle.emailStyle,
            ),
            const Gap(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                GestureDetector(
                  onTap: ()  {
                    navPop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: kToolbarHeight,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: theme.primaryColorDark,
                    ),
                    child: Center(
                      child: Text(
                        'OK',
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