import 'package:flutter/material.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/account_screen.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/category_screen.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/dashboard_screen.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/favorite_screen.dart';

import '../../const/vice_theme.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with TickerProviderStateMixin {
  var _bottomNavIndex = 0;

   

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: 
      [
        DashboardScreen(),
        const CategoryScreen(),
        const FavoriteScreen(),
        const AccountScreen(),
      ]
      [_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _bottomNavIndex,
        fixedColor: theme.primaryColorDark,
        elevation: 0,
        items:  [
          BottomNavigationBarItem(
            activeIcon: const Icon(NavIcons.homeFill),
            backgroundColor: theme.primaryColor,
              icon: Icon( NavIcons.home, color: theme.primaryColorDark), label: "Home"),
          BottomNavigationBarItem(
            activeIcon: const Icon(NavIcons.categoryFill),
            backgroundColor: theme.primaryColor,
              icon: Icon(NavIcons.category, color: theme.primaryColorDark),
              label: "Category"),
          BottomNavigationBarItem(
            activeIcon: const Icon(NavIcons.heartFill),
            backgroundColor: theme.primaryColor,
              icon: Icon(NavIcons.heart, color: theme.primaryColorDark),
              label: "Favorite"),
          BottomNavigationBarItem(
            activeIcon: const Icon(NavIcons.settingsFill),
            backgroundColor: theme.primaryColor,
              icon: Icon(NavIcons.settings, color: theme.primaryColorDark),
              label: "Account"),
        ],
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
