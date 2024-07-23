import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/models/cart_model.dart';

class ProductPart extends StatelessWidget {
  final int total;
  final int totalQty;
  final List<CartModel> cartLists;
  const ProductPart({super.key, required this.cartLists, required this.total, required this.totalQty});


  
  @override
  Widget build(BuildContext context) {

   

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ExpandableNotifier(
            initialExpanded: true,
            child: Expandable(
              collapsed: ExpandableButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Details',
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
                          'Product Details',
                          style: AppStyle.normalStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Icon(AppIcons.dropup)
                      ],
                    ),
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      cartLists.length,
                      (index) {
                        return ListTile(

                          leading: SizedBox(
                            width: 50,
                            height: 100,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: cartLists[index].imageUrl,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Product Id',
                                    style: AppStyle.descStyle.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '#${cartLists[index].id}',
                                    style: AppStyle.descStyle.copyWith(fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              Text(
                                'Name',
                                style: AppStyle.descStyle.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                    cartLists[index].name,
                                    style: AppStyle.descStyle.copyWith(fontStyle: FontStyle.italic),
                                  ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${cartLists[index].totalPrice} Ks',
                                    style: AppStyle.titleStyle,
                                  ),
                                  Text(
                                    'Qty: ${cartLists[index].quantity}',
                                    style: AppStyle.descStyle.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),                              
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const Gap(10),
          const Divider(),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub Total',
                style: AppStyle.normalStyle,
              ),
              Text(
                '$total Ks',
                style:
                    AppStyle.normalStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Qty',
                style: AppStyle.normalStyle,
              ),
              Text(
                '$totalQty',
                style:
                    AppStyle.normalStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery',
                style: AppStyle.normalStyle,
              ),
              Text(
                'Pick Up',
                style: AppStyle.normalStyle
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
          const Gap(10.0),
          
        ],
      ),
    );
  }
}
