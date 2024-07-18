import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/core/models/cart_model.dart';
import 'package:shop_init/src/core/models/item_model.dart';
import 'package:shop_init/src/core/notifier/selected_notifier.dart';
import 'package:shop_init/src/core/state_management/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/widgets/divider.dart';
import 'package:shop_init/src/presentation/views/products/components/checkout_part.dart';
import 'package:shop_init/src/presentation/views/products/components/color_part.dart';
import 'package:shop_init/src/presentation/views/products/components/plus_minus_part.dart';
import 'package:shop_init/src/presentation/views/products/components/reviews_part.dart';
import 'package:shop_init/src/presentation/views/products/components/sized_part.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ItemModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PageController controller = PageController();
  var currentIndex = 0;
  void onPageChanged(index) {
    currentIndex = index;
  }

  void onDotClicked(index) {
    currentIndex = index;
    controller.jumpTo(index);
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ///mainImage
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  child: PageView(
                    controller: controller,
                    onPageChanged: onPageChanged,
                    children: List.generate(
                      widget.productModel.images!.length + 1,
                      (index) {
                        if (index == 0) {
                          return CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.productModel.imageUrl!,
                          );
                        } else {
                          return Container(
                            width: 80.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey,
                                border: Border.all(width: 1)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.productModel.images![index - 1],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                ///appbar
                const Positioned(
                  child: Column(
                    children: [
                      Gap(30.0),
                      CustomAppBar(
                        isAnimated: false,
                        showSearchBar: false,
                        showDefinedName: true,
                        showCart: false,
                        name: "",
                        showBack: true,
                        showColor: true,
                      ),
                    ],
                  ),
                ),

                ///heart
                Positioned(
                  top: 40,
                  right: 20.0,
                  child: CircleAvatar(
                    radius: 18.0,
                    backgroundColor: theme.primaryColor.withOpacity(.2),
                    child: IconButton(
                      iconSize: 20.0,
                      onPressed: () async {
                        if (widget.productModel.isFavorite == false) {
                          await itemRef
                              .doc('products')
                              .collection(categoryName)
                              .doc(widget.productModel.id)
                              .update({
                            'isFavorite': true,
                          }).whenComplete(
                            () async {
                              await wishListRef
                                  .doc(widget.productModel.id)
                                  .set({
                                'name': widget.productModel.name,
                                'id': widget.productModel.id,
                                'category': widget.productModel.category,
                                'isFavorite': true,
                                'desc': widget.productModel.desc,
                                'stocks': widget.productModel.stocks,
                                'popularity': widget.productModel.popularity,
                                'price': widget.productModel.price,
                                'discountPercent':
                                    widget.productModel.discountPercent,
                                'discountedPrice':
                                    widget.productModel.discountedPrice,
                                'imageUrl': widget.productModel.imageUrl,
                                'attributes': widget.productModel.attributes,
                                'images': widget.productModel.images,
                                'isFeatured': widget.productModel.isFeatured,
                                'isDiscounted':
                                    widget.productModel.isDiscounted,
                                'timestamp': widget.productModel.timestamp,
                              });
                            },
                          );
                          setState(() {
                            widget.productModel.isFavorite = true;
                          });
                        } else {
                          await itemRef
                              .doc('products')
                              .collection(categoryName)
                              .doc(widget.productModel.id)
                              .update({
                            'isFavorite': false,
                          });
                          setState(() {
                            widget.productModel.isFavorite = false;
                          });
                          await wishListRef
                              .doc(widget.productModel.id)
                              .delete()
                              .whenComplete(() {
                            widget.productModel.isFavorite = false;
                          });
                        }
                      },
                      icon: Icon(widget.productModel.isFavorite == false
                          ? ViceIcons.heart
                          : ViceIcons.heartFill),
                    ),
                  ),
                ),

                ///images
                Positioned(
                  bottom: 10,
                  left: 10.0,
                  right: 10.0,
                  child: SmoothPageIndicator(
                      controller: controller,
                      count: widget.productModel.images!.length + 1,
                      onDotClicked: onDotClicked,
                      axisDirection: Axis.horizontal,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.black,
                        dotColor: Colors.white,
                        dotHeight: 10,
                        dotWidth: 30,
                      )),
                ),
              ],
            ),

            ///details
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.yellow.withOpacity(.8),
                        ),
                        child: Text(' ${widget.productModel.discountPercent}% ',
                            style: ProductStyle.discountStyle.copyWith(color: theme.primaryColorDark),),
                      ),
                      const Gap(10.0),
                      Text(
                        '${widget.productModel.price}Ks',
                        style: ViceStyle.priceStyle.copyWith(color: theme.primaryColorDark),
                      ),
                      const Gap(10.0),
                      Text(
                        '${widget.productModel.discountedPrice}Ks',
                        style: ViceStyle.discountedPriceStyle.copyWith(color: theme.primaryColorDark),
                      ),
                    ],
                  ),

                  const Gap(10.0),

                  Text(
                    widget.productModel.name ?? '',
                    style: ViceStyle.titleStyle.copyWith(color: theme.primaryColorDark),
                  ),

                  Row(
                    children: [
                      Text(
                        'In Stocks: ',
                        style: ViceStyle.normalStyle.copyWith(color: theme.primaryColorDark),
                      ),
                      Text(widget.productModel.stocks.toString(),
                          style: ViceStyle.normalStyle.copyWith(color: theme.primaryColorDark),),
                    ],
                  ),

                  ///colors
                  const Gap(10.0),
                  Text(
                    'Colors',
                    style: ViceStyle.titleStyle.copyWith(color: theme.primaryColorDark),
                  ),
                  ColorPart(attributes: widget.productModel.attributes),

                  ///sizes
                  Text('Sizes', style: ViceStyle.titleStyle.copyWith(color: theme.primaryColorDark),),

                  SizePart(
                    attributes: widget.productModel.attributes,
                  ),

                  const DividerWidget(),

                  ///checkout
                  const CheckoutPart(),

                  ///sizes
                  const Gap(10.0),

                  Text(
                    'Description',
                    style: ViceStyle.titleStyle.copyWith(color: theme.primaryColorDark),
                  ),
                  const Gap(10.0),
                  Text(
                    widget.productModel.desc ?? '',
                    style: ViceStyle.normalStyle.copyWith(color: theme.primaryColorDark),
                  ),
                  const Gap(10),
                  InkWell(
                    onTap: () {
                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const ReviewSectionPart();
                          });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration:  BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow:  [
                          BoxShadow(
                            offset: const Offset(3, 3),
                            color: theme.primaryColorDark.withOpacity(.2),
                            blurRadius: 6,
                          ),
                         ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            ' Reviews',
                            style: ViceStyle.titleStyle.copyWith(color: theme.primaryColorDark),
                          ),
                          const Spacer(),
                          Icon(Iconsax.arrow_down_1, color: theme.primaryColorDark,)
                        ],
                      ),
                    ),
                  ),
                  const Gap(10.0),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xfffff7f1),
        child: Row(
          children: [
            ///plus minus
            PlusMinusPart(stocks: widget.productModel.stocks!),
        
            const Spacer(),
        
            widget.productModel.stocks! > 0 ? BlocBuilder<AddToCartBloc, CartState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    final cartBloc = context.read<AddToCartBloc>();
                    final cartList = cartBloc.state.cartLists;
        
                    final data = convertToCartModel(widget.productModel,
                        quantity.value, selectedColor.value, selectedSize.value);
        
                    if (cartList
                        .any((item) => item.id == widget.productModel.id)) {
                      Fluttertoast.showToast(
                          msg: "Already Added", backgroundColor: Colors.amber);
                    } else {
                      cartBloc.add(AddToCartEvent(productModel: data));
                      Fluttertoast.showToast(
                          msg: "Product Added To the Cart",
                          backgroundColor: Colors.green);
                          quantity.value = 1;
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'Add To Cart',
                        style: ViceStyle.descStyle,
                      ),
                    ),
                  ),
                );
              },
            ) : Container(
                    margin: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2,color: Colors.black12),
                    ),
                    child: Center(
                      child: Text(
                        'Add To Cart',
                        style: ViceStyle.descStyle.copyWith(color: theme.primaryColorDark.withOpacity(.3)),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

CartModel convertToCartModel(
    ItemModel itemModel, int quantity, String? color, String? size) {
  return CartModel(
    timestamp: Timestamp.now(),
    color: color,
    size: size,
    id: itemModel.id ?? '',
    name: itemModel.name ?? '',
    quantity: quantity,
    price: itemModel.discountedPrice ?? 0,
    category: itemModel.category ?? '',
    stocks: itemModel.stocks ?? 0,
    imageUrl: itemModel.imageUrl ?? '',
    totalPrice: itemModel.discountedPrice! * quantity,
  );
}
