import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/models/order_model.dart';

class OrderDetailsPart extends StatelessWidget {
  final OrderModel orderModel;
  const OrderDetailsPart({super.key,required this.orderModel});

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
                      style: AppStyle.normalStyle
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Icon(AppIcons.dropdown)
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
                          style: AppStyle.normalStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Icon(AppIcons.dropup)
                      ],
                    ),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Id',
                        style: AppStyle.descStyle,
                      ),
                      Text(
                        '#${orderModel.id}',
                        style: AppStyle.descStyle,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Placed',
                        style: AppStyle.descStyle,
                      ),
                      Text(
                        readTimestamp(orderModel.timestamp),
                        style: AppStyle.descStyle,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: AppStyle.descStyle,
                      ),
                      Text(
                        '${orderModel.totalAmt} Ks',
                        style: AppStyle.descStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        
          const Divider(),
          if(orderModel.approve == "pending")
             Text(
              'Pending',
              style: AppStyle.descStyle
                  .copyWith(fontWeight: FontWeight.normal,color: Colors.amber),
            )
            else if(orderModel.approve == "approve")
              Text(
              'Approve',
              style: AppStyle.descStyle
                  .copyWith(fontWeight: FontWeight.normal,color: Colors.green),
            )
            else 
            Text(
              'Reject',
              style: AppStyle.descStyle
                  .copyWith(fontWeight: FontWeight.normal,color: Colors.red),
            )
           
         
        
        ],
        
      ),
    );
  }
}



String readTimestamp( timestamp) {
  
  DateTime dateNow = timestamp.toDate();
  return '${dateNow.day}/${dateNow.month}/${dateNow.year}';
}
