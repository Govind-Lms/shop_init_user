// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:shop_init/src/const/vice_theme.dart';
// import 'package:shop_init/src/core/models/cart_model.dart';

// class ProductDetailsPart extends StatelessWidget {
//   final int total;
//   final int totalQty;
//   final List<CartModel> cartLists;
//   const ProductDetailsPart({super.key, required this.cartLists, required this.total, required this.totalQty});


  
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20.0),
//           height: 130,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: cartLists.length,
//             itemBuilder: (BuildContext context, int index) {
//               final productModel = cartLists[index];
//               return Hero(
//                 tag: productModel.imageUrl,
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 10.0, top: 10),
//                   width: 80.0,
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10.0),
//                     child: CachedNetworkImage(
//                       imageUrl: productModel.imageUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           margin: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
//           padding: const EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             border: Border.all(width: 1),
//             color: Colors.white,
//           ),
//           child: Column(
//             children: [
//               ExpandableNotifier(
//                 child: Expandable(
//                   collapsed: ExpandableButton(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Product Details',
//                           style: ViceStyle.normalStyle
//                               .copyWith(fontWeight: FontWeight.bold),
//                         ),
//                         const Icon(ViceIcons.dropdown)
//                       ],
//                     ),
//                   ),
//                   expanded: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ExpandableButton(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Product Details',
//                               style: ViceStyle.normalStyle
//                                   .copyWith(fontWeight: FontWeight.bold),
//                             ),
//                             const Icon(ViceIcons.dropup)
//                           ],
//                         ),
//                       ),
//                       const Gap(10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: List.generate(
//                           cartLists.length,
//                           (index) {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Product Id',
//                                       style: ViceStyle.descStyle,
//                                     ),
//                                     Text(
//                                       cartLists[index].id,
//                                       style: ViceStyle.descStyle,
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Product Name',
//                                       style: ViceStyle.descStyle,
//                                     ),
//                                     Text(
//                                       cartLists[index].name,
//                                       style: ViceStyle.descStyle,
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       '${cartLists[index].totalPrice} Ks',
//                                       style: ViceStyle.titleStyle,
//                                     ),
//                                     Text(
//                                       'Qty: ${cartLists[index].quantity}',
//                                       style: ViceStyle.descStyle,
//                                     ),
//                                   ],
//                                 ),
//                                 const Divider(),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
              
//               const Gap(10),
//               const Divider(),
              
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Sub Total',
//                     style: ViceStyle.normalStyle,
//                   ),
//                   Text(
//                     '$total Ks',
//                     style:
//                         ViceStyle.normalStyle.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const Gap(10.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total Qty',
//                     style: ViceStyle.normalStyle,
//                   ),
//                   Text(
//                     '$totalQty',
//                     style:
//                         ViceStyle.normalStyle.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const Gap(10.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Delivery',
//                     style: ViceStyle.normalStyle,
//                   ),
//                   Text(
//                     'Pick Up',
//                     style: ViceStyle.normalStyle
//                         .copyWith(fontWeight: FontWeight.bold, color: Colors.green),
//                   ),
//                 ],
//               ),
//               const Gap(10.0),
              
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
