import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/state_management/bloc/add_to_cart/add_to_cart_bloc.dart';

class CustomAppBar extends StatelessWidget {
  final bool isAnimated;
  final bool showSearchBar;
  final bool showDefinedName;
  final String? name;
  final bool showCart;
  final bool? showBack;
  final bool? showColor;

  const CustomAppBar(
      {super.key,
      this.showColor,
      required this.isAnimated,
      required this.showSearchBar,
      this.name,
      required this.showDefinedName,
      required this.showCart,
      this.showBack});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return isAnimated
        ? FadeInDown(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        showBack == true
                            ? IconButton(
                                onPressed: () {
                                  navPop(context);
                                },
                                icon: CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: showColor == true
                                        ? theme.primaryColor
                                        : Colors.transparent,
                                    child: Icon(
                                      CupertinoIcons.back,
                                      color: theme.primaryColorDark,
                                    )))
                            : Container(),
                        Text(
                          showDefinedName
                              ? '$name'
                              : '${firebaseAuth.currentUser?.displayName}',
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: theme.primaryColorDark,
                          ),
                        ),
                        const Spacer(),
                        showCart == true
                            ? BlocBuilder<AddToCartBloc, CartState>(
                                builder: (context, state) {
                                  final cartBloc =
                                      context.read<AddToCartBloc>();
                                  final cartList = cartBloc.state.cartLists;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/checkout');
                                    },
                                    child: cartList.length == 0
                                        ? Icon(
                                            AppIcons.cart,
                                            color: theme.primaryColorDark,
                                          )
                                        : Badge(
                                            label: Text(
                                                cartList.length.toString()),
                                            child: Icon(
                                              AppIcons.cart,
                                              color: theme.primaryColorDark,
                                            )),
                                  );
                                },
                              )
                            : Container(),
                        Gap(10),
                      ],
                    ),
                  ),
                  showSearchBar ? const Gap(20) : const Gap(0),
                  showSearchBar
                      ? Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.shade100,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(3, 3),
                                  blurRadius: 6,
                                  color: Colors.black12,
                                )
                              ]),
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(AppIcons.search),
                                border: InputBorder.none,
                                hintText: 'Search'),
                          ))
                      : Container(),
                ],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showBack == true
                        ? IconButton(
                            onPressed: () {
                              navPop(context);
                            },
                            icon: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: showColor == true
                                    ? theme.primaryColor
                                    : Colors.transparent,
                                child: Icon(
                                  CupertinoIcons.back,
                                  color: theme.primaryColorDark,
                                )))
                        : Container(),
                    Text(
                      showDefinedName
                          ? name.toString()
                          : '${firebaseAuth.currentUser?.displayName}',
                      style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColorDark,
                      ),
                    ),
                    const Spacer(),
                    showCart == true
                        ? BlocBuilder<AddToCartBloc, CartState>(
                            builder: (context, state) {
                              final cartBloc = context.read<AddToCartBloc>();
                              final cartList = cartBloc.state.cartLists;
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/checkout');
                                },
                                child: cartList.length == 0
                                    ? Icon(
                                        AppIcons.cart,
                                        color: theme.primaryColorDark,
                                      )
                                    : Badge(
                                        label: Text(cartList.length.toString()),
                                        child: Icon(
                                          AppIcons.cart,
                                          color: theme.primaryColorDark,
                                        )),
                              );
                            },
                          )
                        : const SizedBox(),
                    const Gap(10),
                  ],
                ),
                showSearchBar ? const Gap(20) : const Gap(0),
                showSearchBar
                    ? Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.shade100,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(3, 3),
                                blurRadius: 6,
                                color: Colors.black12,
                              )
                            ]),
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(AppIcons.search),
                              border: InputBorder.none,
                              hintText: 'Search'),
                        ))
                    : Container(),
              ],
            ),
          );
  }
}
