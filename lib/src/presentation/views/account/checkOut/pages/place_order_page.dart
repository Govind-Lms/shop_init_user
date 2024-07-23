import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/models/cart_model.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/components/comfirm_dialog.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/components/order_id_part.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/components/product_part.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/components/shipping_address.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';
import 'package:slider_button/slider_button.dart';

class OrderBottomSheet extends StatefulWidget {
  const OrderBottomSheet({super.key, required this.cartLists});
  final List<CartModel> cartLists;

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  int totalAmt = 0;

  int totalQty = 0;

  @override
  void initState() {
    super.initState();
    calculateQty();
    calculateTotal();
  }

  calculateTotal() {
    for (int i = 0; i < widget.cartLists.length; i++) {
      totalAmt = widget.cartLists[i].totalPrice + totalAmt;
    }
    return totalAmt;
  }

  calculateQty() {
    for (int i = 0; i < widget.cartLists.length; i++) {
      totalQty = widget.cartLists[i].quantity + totalQty;
    }
    return totalQty;
  }

  final orderId = Random().nextInt(1000000000);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                isAnimated: false,
                showSearchBar: false,
                showDefinedName: true,
                showCart: false,
                name: 'Checkout',
                showBack: true,
                showColor: false,
              ),
              const ShippingAddress(),
              OrderIdPart(
                total: totalAmt,
                orderId: orderId.toString(),
              ),
              ProductPart(
                  cartLists: widget.cartLists,
                  total: totalAmt,
                  totalQty: totalQty),
              
              Container(
                margin: const EdgeInsets.all(20),
                height: kToolbarHeight,
                child: SliderButton(
                  
                  action: () async{
                     showDialog(
                        context: context,
                        builder: (context) {
                          return OrderConfirmDialog(
                            cartLists: widget.cartLists,
                            orderId: orderId,
                            total: totalAmt,
                            totalQty: totalQty,
                          );
                        });
                        return true;
                  },
                  label: Text(
                    "Slide to Place Order!",
                    style: AppStyle.normalStyle,
                  ),
                  icon: Center(
                    child: Icon(
                      Iconsax.arrow_right,
                      color: theme.primaryColorDark,
                      size: 24.0,
                    ),
                  ),
                  width: double.infinity,
                  buttonColor: theme.primaryColorLight,
                  backgroundColor: theme.primaryColorDark,
                  highlightedColor: theme.primaryColorDark,
                  baseColor: theme.primaryColor,
                ),
              ),
             
            ],
          ),
        )));
  }
}
