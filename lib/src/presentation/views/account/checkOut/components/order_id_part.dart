import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/vice_theme.dart';

class OrderIdPart extends StatelessWidget {
  final int total;
  final String orderId;
  const OrderIdPart({super.key,required this.total, required this.orderId});

  @override
  Widget build(BuildContext context) {

    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandableNotifier(
            initialExpanded: true,
            child: Expandable(
              collapsed: ExpandableButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Details',
                      style: ViceStyle.normalStyle
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Icon(ViceIcons.dropdown)
                  ],
                ),
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandableButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Details',
                          style: ViceStyle.normalStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Icon(ViceIcons.dropup)
                      ],
                    ),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Id',
                        style: ViceStyle.descStyle,
                      ),
                      Text(
                        '#$orderId',
                        style: ViceStyle.descStyle,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Placed',
                        style: ViceStyle.descStyle,
                      ),
                      Text(
                        readTimestamp(Timestamp.now()),
                        style: ViceStyle.descStyle,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: ViceStyle.descStyle,
                      ),
                      Text(
                        '$total Ks',
                        style: ViceStyle.descStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        
          const Divider(),
          Text(
            'Shipping Details',
            style: ViceStyle.descStyle
                .copyWith(fontWeight: FontWeight.normal),
          ),
         
        
        ],
        
      ),
    );
  }
}



String readTimestamp( timestamp) {
  
  DateTime dateNow = timestamp.toDate();
  return '${dateNow.day}/${dateNow.month}/${dateNow.year}';
}
