
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String accessToken = "";
final navigatorKey = GlobalKey<NavigatorState>();

const url = "https://fcm.googleapis.com/v1/projects/sho-pinit/messages:send";



navNameReplacement(context, name) => Navigator.of(context).pushReplacementNamed(name);
navName(context, name) => Navigator.of(context).pushNamed(name);
navPop(context) => Navigator.of(context).pop(true);
nav(context, screen) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> screen ));

final onBoardingImages = [
  'assets/onboarding/searching.gif',
  'assets/onboarding/shopping.gif',
  'assets/onboarding/delivery.gif',
];
final onBoardingTitles = [
  'Choose Your Product',
  'Select Payment Method',
  'Deliver at your door step'
];
final onBoardingSubtitles = [
  'Welcome to a world or limitiess cholces - your rertect Product Awaits!',
  'For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!',
  'From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!'
];

final userRef = FirebaseFirestore.instance.collection('users');
final tokenRef = FirebaseFirestore.instance.collection('tokens');
final wishListRef = userRef.doc(firebaseAuth.currentUser?.uid).collection('wishLists');
final orderLengthRef = FirebaseFirestore.instance.collection('totalOrders');
final itemRef = FirebaseFirestore.instance.collection('items');
final orderRef = FirebaseFirestore.instance.collection('orders');
final orderListRef = FirebaseFirestore.instance.collection('orderLists');
final bannerRef = FirebaseFirestore.instance.collection("banners");

final firebaseAuth = FirebaseAuth.instance;

String categoryName = '';
final List<String> categoryNames = [
  'tee',
  'outerwear',
  'sneaker',
  'hoodie',
];
final List<Color> colors = [
  const Color(0xff9872f9),
  const Color(0xffff8c8d),
  const Color(0xff42c1ac),
  const Color(0xff7183ff),
];
final List<String> images = [
  'assets/img/category/tee.png',
  'assets/img/category/outerwear.png',
  'assets/img/category/sneaker.png',
  'assets/img/category/hoodie.png',
];
final List<double> angles = [
  -45,
  -45,
  0,
  -45,
];


class AccountStyle {
  AccountStyle._();
  static TextStyle nameStyle = GoogleFonts.poppins().copyWith(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
  );
  static TextStyle logoutStyle = GoogleFonts.poppins().copyWith(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
  );

  static TextStyle emailStyle = GoogleFonts.poppins().copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static TextStyle settingStyle = GoogleFonts.poppins().copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
   static TextStyle settingDescStyle = GoogleFonts.poppins().copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}


class ProductStyle {
  ProductStyle._();
  static TextStyle discountStyle = GoogleFonts.poppins().copyWith(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
  );


  static TextStyle productNameStyle = GoogleFonts.poppins().copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );


  static TextStyle categoryStyle = GoogleFonts.poppins().copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    wordSpacing: 10
  );

  static TextStyle priceStyle = GoogleFonts.poppins().copyWith(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    wordSpacing: 10,
  );
}
