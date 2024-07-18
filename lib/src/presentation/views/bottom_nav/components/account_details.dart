import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/widgets/divider.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = firebaseAuth.currentUser!;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          const CustomAppBar(
            isAnimated: false,
            showSearchBar: false,
            showDefinedName: true,
            showCart: false,
            showBack: true,
            name: 'Details',
          ),
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: user.photoURL!,
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(10),
                Text(
                  'Change profile picture',
                  style: AccountStyle.settingDescStyle,
                ),
                const Gap(10.0),
                const DividerWidget(),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Infomation'.toUpperCase(),
                    style: AccountStyle.nameStyle,
                  ),
                  const Gap(10.0),
                  Row(
                    children: [
                      Text(
                        'Name'.toUpperCase(),
                        style: AccountStyle.emailStyle,
                      ),
                      const Spacer(),
                      Text(
                        user.displayName!,
                        style: AccountStyle.emailStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      // const Spacer(),
                    ],
                  ),
                  const Gap(10.0),
                  Row(
                    children: [
                      Text(
                        'email'.toUpperCase(),
                        style: AccountStyle.emailStyle,
                      ),
                      const Spacer(),
                      Text(
                        user.email!,
                        style: AccountStyle.emailStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Gap(10.0),
                ],
              )),
          const DividerWidget(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Infomation'.toUpperCase(),
                    style: AccountStyle.nameStyle,
                  ),
                  const Gap(10.0),
                  Row(
                    children: [
                      Text(
                        'UID'.toUpperCase(),
                        style: AccountStyle.emailStyle,
                      ),
                      const Spacer(),
                      Text(
                        user.uid.toString(),
                        style: AccountStyle.emailStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      // const Spacer(),
                    ],
                  ),
                  const Gap(10.0),
                  Row(
                    children: [
                      Text(
                        'phone No'.toUpperCase(),
                        style: AccountStyle.emailStyle,
                      ),
                      const Spacer(),
                      Text(
                        user.phoneNumber.toString(),
                        style: AccountStyle.emailStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Gap(10.0),
                ],
              )),
          const DividerWidget(),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Close Account',
                style: AccountStyle.settingStyle.copyWith(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
