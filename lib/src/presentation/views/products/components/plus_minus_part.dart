import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/notifier/quantity_notifier.dart';
import 'package:shop_init/src/core/notifier/selected_notifier.dart';

class PlusMinusPart extends StatelessWidget {
  final int stocks;
  PlusMinusPart({super.key, required this.stocks});

  final counter = Counter();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: counter.quantity,
        builder: (context, value, child) {
          return Row(
            children: [
              const Gap(20),

              ///plus minus
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey,
                child: IconButton(
                  icon: const Icon(ViceIcons.minus),
                  iconSize: 20,
                  color: Colors.white,
                  onPressed: () {
                    if(stocks>0){
                      if (value >= 1) {
                        counter.quantity.value = value - 1;
                        quantity.value = counter.quantity.value;
                      } else {
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(msg: "zero");
                      }
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  stocks >0 ? counter.quantity.value.toString() : "0",
                  style: ViceStyle.normalStyle,
                ),
              ),
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: const Icon(ViceIcons.plus),
                  iconSize: 20,
                  color: Colors.white,
                  onPressed: () {
                    if(stocks>0){
                      if (counter.quantity.value < stocks) {
                      counter.quantity.value = counter.quantity.value + 1;
                      counter.quantity.value + 1;
                      quantity.value = counter.quantity.value;
                      
                    } else {
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(msg: "Out Of Stocks");
                    }
                    }
                    
                  },
                ),
              ),
            ],
          );
        });
  }
}
