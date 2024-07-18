import 'package:flutter/material.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/models/cart_model.dart';
import 'package:shop_init/src/core/models/order_model.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/components/product_part.dart';
import 'package:shop_init/src/presentation/views/account/my_orders/components/receipt_dialog.dart';
import 'package:shop_init/src/presentation/views/account/my_orders/page/delivery_page.dart';
import 'package:shop_init/src/presentation/views/account/my_orders/page/e_receipt_page.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';

class ProductsPage extends StatelessWidget {
  final String userId;
  final OrderModel orderModel;

  const ProductsPage(
      {super.key, required this.userId, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(
                isAnimated: false,
                showSearchBar: false,
                showDefinedName: true,
                name: 'Order Details',
                showBack: true,
                showColor: false,
                showCart: false,
              ),
              StreamBuilder(
                stream: orderRef
                    .doc(firebaseAuth.currentUser!.uid)
                    .collection("orders")
                    .doc(orderModel.id)
                    .collection('items')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    return Builder(
                      builder: (BuildContext context) {
                        List<CartModel> cartLists = [];

                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          cartLists.add(CartModel.fromJson(
                              snapshot.data!.docs[i].data()));
                        }

                        return ProductPart(
                          cartLists: cartLists,
                          totalQty: orderModel.totalQty,
                          total: orderModel.totalAmt,
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if(orderModel.approve == 'approve'){
                nav(context, EReceiptScreen(orderModel: orderModel));
              }
              else if(orderModel.approve == "reject"){
                showDialog(context: context, builder: (context){
                  return const ReceiptDialog(message: "Sorry your order has been rejected...",title: "Rejected",);
                });
              }
              else{
                showDialog(context: context, builder: (context){
                  return  const ReceiptDialog(message: "Wait up until several changes occur...",title: "Please Wait",);
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.white),
                color: Theme.of(context).primaryColorDark,
              ),
              child: Center(
                child: Text(
                  'View E Receipt',
                  style:
                      ViceStyle.descStyle.copyWith(color: theme.primaryColor),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if(orderModel.approve == 'approve'){
                nav(context, DeliveryPage(orderModel: orderModel));
              }
              else if(orderModel.approve == "reject"){
                showDialog(context: context, builder: (context){
                  return const ReceiptDialog(message: "Sorry your order has been rejected...",title: "Rejected",);
                });
              }
              else{
                showDialog(context: context, builder: (context){
                  return  const ReceiptDialog(message: "Wait up until several changes occur...",title: "Please Wait",);
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.white),
                color: Theme.of(context).primaryColorDark,
              ),
              child: Center(
                child: Text(
                  'Delivery',
                  style:
                      ViceStyle.descStyle.copyWith(color: theme.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
