import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/core/helper/authentication.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            const Gap(20.0),
            Text(
              'LOGOUT'.toUpperCase(),
              style: AccountStyle.nameStyle,
            ),
            const Gap(20.0),
            Text(
              'Are you sure you want to quit?',
              style: AccountStyle.emailStyle,
            ),
            const Gap(20.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
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
                  onTap: () async{
                    await AuthRepo().signOutFromGoogle();
                    Navigator.of(context).pop();
                    navNameReplacement(context,'/signIn');
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
                        'Logout',
                        style: AccountStyle.logoutStyle.copyWith(color: Theme.of(context).primaryColor),
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
