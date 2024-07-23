import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';



class AppIcons {
  const AppIcons._();
  static const IconData search = CupertinoIcons.search;
  static const IconData dropdown = Icons.arrow_drop_down;
  static const IconData dropup = Icons.arrow_drop_up;
  static const IconData check = CupertinoIcons.check_mark;
  static const IconData edit = CupertinoIcons.person;
  static const IconData minus = CupertinoIcons.minus;
  static const IconData plus = CupertinoIcons.plus;
  static const IconData menu = CupertinoIcons.line_horizontal_3_decrease;
  static const IconData lock = CupertinoIcons.lock_fill;
  static const IconData home = CupertinoIcons.home;
  static const IconData settings = CupertinoIcons.settings;
  static const IconData share = CupertinoIcons.share;
  static const IconData heart = CupertinoIcons.heart;
  static const IconData close = CupertinoIcons.clear_circled_solid;
  static const IconData save = CupertinoIcons.bookmark;
  static const IconData noti = CupertinoIcons.bell;
  static const IconData category = Icons.dashboard;
  static const IconData cart = CupertinoIcons.shopping_cart;
  static const IconData heartFill = CupertinoIcons.heart_fill;
}

class NavIcons{
  const NavIcons._();
  static const IconData home = Iconsax.home;
  static const IconData category = Iconsax.category;
  static const IconData heart = Iconsax.heart;
  static const IconData settings = Iconsax.setting_3;

  static const IconData homeFill = Iconsax.home5;
  static const IconData categoryFill = Iconsax.category5;
  static const IconData heartFill = Iconsax.heart5;
  static const IconData settingsFill = Iconsax.setting_35;
}

class AppStyle {
  AppStyle._();
  static  TextStyle titleStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: Colors.black,
  );
  static  TextStyle normalStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    color: Colors.black,
  );
  static  TextStyle descStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.normal,
    fontSize: 12.0,
    color: Colors.black,
  );
  static  TextStyle priceStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.normal,
    fontSize: 12.0,
    color: Colors.black,
    decoration: TextDecoration.lineThrough,
  );
  


}


