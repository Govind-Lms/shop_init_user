import 'package:flutter/material.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/core/models/order_model.dart';
import 'package:shop_init/src/presentation/views/account/my_orders/components/order_details_part.dart';
import 'package:shop_init/src/presentation/views/account/my_orders/page/onclick_order.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';
import 'package:shop_init/src/presentation/widgets/empty.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          children:  [
            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              showCart: false,
              name: 'My Orders',
              showBack: true,
            ),
            Expanded(
              child: StreamBuilder(
                stream: orderRef.doc(firebaseAuth.currentUser!.uid).collection("orders").orderBy('timestamp',descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    if(snapshot.data!.docs.isNotEmpty){
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final orderModel = OrderModel.fromJson(snapshot.data!.docs[index].data());
                        return InkWell(
                          onTap: (){
                            nav(context, ProductsPage(userId: orderModel.uid,orderModel: orderModel,));
                          },
                          child: OrderDetailsPart(
                            orderModel: orderModel,
                          )
                        );
                      },
                    );
                    }
                    else{
                      return const EmptyPage(title: "No Orders Placed Yet!",);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




