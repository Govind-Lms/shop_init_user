import 'package:flutter/material.dart';
import 'package:shop_init/src/const/vice_theme.dart';


class EmptyPage extends StatelessWidget {
  final String title;
  const EmptyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/onboarding/shopping.gif'),
            ),
            Text(title,style: AppStyle.titleStyle.copyWith(color: Theme.of(context).primaryColorDark),),

            // InkWell(
            //   onTap: () {
            //     navNameReplacement(context, '/');
            //   },
              
            //   child: Container(
            //     margin: const EdgeInsets.symmetric(
            //         horizontal: 20, vertical: 20),
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       borderRadius:
            //           BorderRadius.circular(10.0),
            //       color: Colors.blue,
            //     ),
            //     child: Center(
            //       child: Text(
            //         'Continue Shopping',
            //         style: ViceStyle.normalStyle.copyWith(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
