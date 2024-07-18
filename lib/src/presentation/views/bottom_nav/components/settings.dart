import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/widgets/logout_dialog.dart';

class SettingsPart extends StatelessWidget {
  const SettingsPart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      // height: MediaQuery.of(context).size.height/2,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Theme.of(context).primaryColor.withOpacity(.1),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Account Settings'.toUpperCase(),
            //   style: AccountStyle.nameStyle,
            // ),
            const Gap(10.0),
            ListTile(
              onTap: () {},
              leading:  Icon(CupertinoIcons.home,color: theme.primaryColorDark,),
              title: Text(
                'My Addresses',
                style: AccountStyle.settingStyle
                    .copyWith(color: theme.primaryColorDark),
              ),
              subtitle: Text(
                'Set delivery addresses and shipping codes',
                style: AccountStyle.settingDescStyle.copyWith(color: theme.primaryColorDark),
              ),
            ),
            ListTile(
              onTap: () {
                navName(context, '/checkout');
              },
              leading:  Icon(CupertinoIcons.cart,color: theme.primaryColorDark,),
              title: Text(
                'My Cart',
                style: AccountStyle.settingStyle.copyWith(color: theme.primaryColorDark),
              ),
              subtitle: Text(
                'Add / Remove products and move to check out',
                style: AccountStyle.settingDescStyle.copyWith(color: theme.primaryColorDark),
              ),
            ),
            ListTile(
              onTap: () {
                navName(context, '/myOrders');
              },
              leading:  Icon(CupertinoIcons.bag,color: theme.primaryColorDark,),
              title: Text(
                'My Orders',
                style: AccountStyle.settingStyle.copyWith(color: theme.primaryColorDark),
              ),
              subtitle: Text(
                'In-progress and Completed Orders',
                style: AccountStyle.settingDescStyle.copyWith(color: theme.primaryColorDark),
              ),
            ),
            ListTile(
              onTap: () {
                navName(context, '/notification');
              },
              leading:  Icon(CupertinoIcons.bell,color: theme.primaryColorDark,),
              title: Text(
                'Notifications',
                style: AccountStyle.settingStyle.copyWith(color: theme.primaryColorDark),
              ),
              subtitle: Text(
                'Set any kind of notificatons ',
                style: AccountStyle.settingDescStyle.copyWith(color: theme.primaryColorDark),
              ),
            ),
            ListTile(
              onTap: () {},
              leading:  Icon(CupertinoIcons.person,color: theme.primaryColorDark,),
              title: Text(
                'Account Privacy',
                style: AccountStyle.settingStyle.copyWith(color: theme.primaryColorDark),
              ),
              subtitle: Text(
                'Manage data usage and connected accounts',
                style: AccountStyle.settingDescStyle.copyWith(color: theme.primaryColorDark),
              ),
            ),
            const Gap(20.0),
            // Text(
            //   'App Settings'.toUpperCase(),
            //   style: AccountStyle.nameStyle,
            // ),
            ListTile(
              leading:  Icon(CupertinoIcons.location,color: theme.primaryColorDark,),
              title: Text(
                'Geo-Location',
                style: AccountStyle.settingStyle.copyWith(color: theme.primaryColorDark),
              ),
              // subtitle: Text('Manage data usage and connected accounts',style: AccountStyle.settingDescStyle,),
              trailing: Switch(
                onChanged: (value) {},
                value: true,
                activeColor: Theme.of(context).primaryColor,
                activeTrackColor: theme.primaryColorDark,
              ),
            ),
            const Gap(20.0),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => const LogOutDialog());
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                height: kToolbarHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 1, color: theme.primaryColorDark),
                ),
                child:  Center(
                  child: Text('Logout',style: AccountStyle.logoutStyle.copyWith(color: theme.primaryColorDark,),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
