import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/notifier/quantity_notifier.dart';
import 'package:shop_init/src/core/state_management/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:shop_init/src/presentation/views/account/checkOut/pages/place_order_page.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';
import 'package:shop_init/src/presentation/widgets/empty.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  
  final counter = Counter();
  @override  
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              showCart: false,
              name: 'My Cart',
              showBack: true,
            ),
            Expanded(
              child: BlocListener<AddToCartBloc, CartState>(
                listener: (context, state) {
                  print("LIST :::${state.cartLists.length.toString()}");
                },
                child: BlocBuilder<AddToCartBloc, CartState>(
                  builder: (context, state) {
                    if (state.cartLists.isEmpty) {
                      return const Center(
                        child: EmptyPage(title: "Add some to the cart"),
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.cartLists.length,
                              itemBuilder: (BuildContext context, int index) {
                                final cartModel = state.cartLists;
                                return Container(
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Hero(
                                            tag: cartModel[index].imageUrl,
                                            child: SizedBox(
                                              width: 70.0,
                                              height: 100.0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: cartModel[index].imageUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Gap(20.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartModel[index].category,
                                                style: ProductStyle.categoryStyle.copyWith(color: theme.primaryColorDark),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width /2,
                                                child: Text(
                                                  cartModel[index].name,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: ProductStyle.productNameStyle.copyWith(color: theme.primaryColorDark),
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Color ',
                                                      style: ProductStyle.categoryStyle.copyWith(color: theme.primaryColorDark),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                            '${cartModel[index].color} ',
                                                        style: ProductStyle
                                                            .categoryStyle
                                                            .copyWith(
                                                              color: theme.primaryColorDark,
                                                                fontWeight:
                                                                    FontWeight.bold)),
                                                    TextSpan(
                                                      text: 'Size ',
                                                      style: ProductStyle.categoryStyle.copyWith(color: theme.primaryColorDark),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                            '${cartModel[index].size} ',
                                                        style: ProductStyle
                                                            .categoryStyle
                                                            .copyWith(
                                                              color: theme.primaryColorDark,
                                                                fontWeight:
                                                                    FontWeight.bold)),
                                                  ],
                                                ),
                                              ),
                                              ValueListenableBuilder(
                                                  valueListenable: counter.quantity,
                                                  builder: (context, value, child) {
                                                    return SizedBox(
                                                      width: MediaQuery.of(context).size.width /2 + 50,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 15.0,
                                                            backgroundColor:
                                                                Colors.grey,
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                  AppIcons.minus),
                                                              iconSize: 15,
                                                              color: Colors.white,
                                                              onPressed: () {
                                                                if (value >= 1) {
                                                                  
                                                                  cartModel[index].quantity =cartModel[index].quantity -1;
                                                                  setState(() {
                                                                    cartModel[index].quantity -1;
                                                                  });
                                                                  print(cartModel[index].quantity);
                                                                  cartModel[index].totalPrice =cartModel[index].price * cartModel[index].quantity;
                                                                  print("total ${cartModel[index].totalPrice}");
                                                                } else {
                                                                  Fluttertoast.cancel();
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg: "zero");
                                                                }
                                                  
                                                                if (cartModel[index]
                                                                        .quantity <
                                                                    1) {
                                                                  context
                                                                      .read<
                                                                          AddToCartBloc>()
                                                                      .add(RemoveFromCartEvent(
                                                                          productModel:
                                                                              cartModel[
                                                                                  index]));
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    10.0),
                                                            child: Text(
                                                              '${cartModel[index].quantity}',
                                                              style:
                                                                  AppStyle.normalStyle.copyWith(color: theme.primaryColorDark),
                                                            ),
                                                          ),
                                                          CircleAvatar(
                                                            radius: 15.0,
                                                            backgroundColor:
                                                                Theme.of(context)
                                                                    .primaryColorDark,
                                                            child: IconButton(
                                                                icon:  Icon(
                                                                    AppIcons.plus,color: theme.primaryColor,),
                                                                iconSize: 15,
                                                                color: Colors.white,
                                                                onPressed: () {
                                                                  if (counter.quantity.value < cartModel[index] .stocks) {
                                                                    
                                                                    cartModel[index].quantity = cartModel[index].quantity + 1;
                                                                    setState(() {
                                                                      cartModel[index].quantity + 1;
                                                                    });
                                                                    print(cartModel[index].quantity);
                                                                    cartModel[index]
                                                                            .totalPrice =
                                                                        cartModel[index]
                                                                                .price *
                                                                            cartModel[
                                                                                    index]
                                                                                .quantity;
                                                                    print(
                                                                        "total ${cartModel[index].totalPrice}");
                                                                  } else {
                                                                    Fluttertoast
                                                                        .cancel();
                                                                    Fluttertoast.showToast(
                                                                        msg:
                                                                            "Out Of Stocks");
                                                                  }
                                                                }),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            textAlign: TextAlign.end,
                                                            "${cartModel[index].price * cartModel[index].quantity}Ks",
                                                            style: ProductStyle
                                                                .priceStyle
                                                                .copyWith(fontSize: 14,color: theme.primaryColorDark),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          )
                                        ],
                                      ),
                                    
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: CircleAvatar(
                                          radius: 20.0,
                                          backgroundColor: theme.primaryColorDark,
                                          child: IconButton(
                                            onPressed: (){
                                              context.read<AddToCartBloc>()
                                                .add(RemoveFromCartEvent(
                                                  productModel:cartModel[index],
                                                ),
                                              );
                                            },
                                            icon:  Icon(Iconsax.trash,size: 20,color: theme.primaryColor,),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              nav(
                                  context,
                                  OrderBottomSheet(
                                    cartLists: state.cartLists,
                                  ));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              height: kToolbarHeight,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Theme.of(context).primaryColorDark,
                              ),
                              child: Center(
                                child: Text(
                                  'Pre-order',
                                  style: AppStyle.normalStyle
                                      .copyWith(color: theme.primaryColor),
                                ),
                              ),
                            ),
                          ),
                          const Gap(20),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
