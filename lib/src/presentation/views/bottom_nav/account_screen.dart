import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/components/settings.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final user = firebaseAuth.currentUser!;
    final theme = Theme.of(context);

    return ListView(
      children: [
        const CustomAppBar(
          isAnimated: false,
          showSearchBar: false,
          showDefinedName: true,
          name: 'Account',
          showCart: false,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Center(
                child: ClipOval(
                  child: CachedNetworkImage(
                    width: 60.0,
                    height: 60.0,
                    imageUrl: user.photoURL.toString(),
                  ),
                ),
              ),
              const Gap(10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName.toString(),
                    style: AccountStyle.nameStyle.copyWith(fontSize: 14,color: theme.primaryColorDark),
                  ),
                  Text(
                    user.email.toString(),
                    style: AccountStyle.emailStyle.copyWith(fontSize: 12,color: theme.primaryColorDark),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    navName(context, '/account_details');
                  },
                  icon:  Icon(
                    AppIcons.edit,
                    color: theme.primaryColorDark,
                  )),
              const Gap(10.0),
            ],
          ),
        ),
        const Gap(10.0),
        const SettingsPart(),
      ],
    );
  }
}
