import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/models/item_model.dart';
import 'package:shop_init/src/core/notifier/quantity_notifier.dart';
import 'package:shop_init/src/core/state_management/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:shop_init/src/presentation/views/products/product_details.dart';

class ProductDesign extends StatefulWidget {
  final ItemModel productModel;
  const ProductDesign({super.key, required this.productModel});

  @override
  State<ProductDesign> createState() => _ProductDesignState();
}

class _ProductDesignState extends State<ProductDesign> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        nav(context, ProductDetailsScreen(productModel: widget.productModel));
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.productModel.imageUrl!,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 150,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: CachedNetworkImage(
                          imageUrl: widget.productModel.imageUrl ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                        )),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.yellow.withOpacity(.8),
                    ),
                    child: Text(
                        '${widget.productModel.discountPercent!.isEmpty ? "0" : widget.productModel.discountPercent}%',
                        style: ProductStyle.discountStyle),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: CircleAvatar(
                    radius: 18.0,
                    backgroundColor: Colors.white.withOpacity(.5),
                    child: IconButton(
                      iconSize: 20.0,
                      onPressed: () async {
                        if (widget.productModel.isFavorite == false) {
                          await itemRef
                              .doc('products')
                              .collection(
                                  widget.productModel.category.toString())
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
                              .collection(
                                  widget.productModel.category.toString())
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
                          : ViceIcons.heartFill,color: theme.primaryColorDark,),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Text(
                    widget.productModel.name ?? '',
                    style: ProductStyle.productNameStyle,
                  ),
                ],
              ),
            ),
                
            ///price
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: widget.productModel.isDiscounted == true ||
                      widget.productModel.discountPercent != '' ||
                      widget.productModel.discountedPrice != 0
                  ? Text(
                      '${widget.productModel.price}Ks',
                      style: ProductStyle.categoryStyle.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  : Text(
                      '${widget.productModel.price}Ks',
                      style: ProductStyle.priceStyle,
                    ),
            ),
                
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.productModel.isDiscounted == true ||
                          widget.productModel.discountPercent != '' ||
                          widget.productModel.discountedPrice != 0
                      ? Text(
                          '${widget.productModel.discountedPrice}Ks',
                          style: ProductStyle.priceStyle.copyWith(
                            color: Colors.green,
                          ),
                        )
                      : Text(
                          '${widget.productModel.price}Ks',
                          style: ProductStyle.priceStyle,
                        ),
                  widget.productModel.stocks! > 0 ?  BlocBuilder<AddToCartBloc, CartState>(
                    builder: (context, state) {
                      final cartBloc = context.read<AddToCartBloc>();
                      final cartList = cartBloc.state.cartLists;
                      return GestureDetector(
                          onTap: () {
                            final data = convertToCartModel(widget.productModel,
                                Counter().quantity.value, '', '');
                            if (cartList.any(
                                (item) => item.id == widget.productModel.id)) {
                              Fluttertoast.cancel();
                              Fluttertoast.showToast(
                                msg: "Already Added",
                                backgroundColor: Colors.amber,
                              );
                            } else {
                              cartBloc.add(AddToCartEvent(productModel: data));
                              Fluttertoast.cancel();
                              Fluttertoast.showToast(
                                msg: "Product Added to the Cart",
                                backgroundColor: Colors.green,
                              );
                            }
                          },
                          child: cartList.any(
                                  (item) => item.id == widget.productModel.id)
                              ? Container(
                                  width: 40,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(9.0),
                                    ),
                                    color: theme.primaryColorDark,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      ViceIcons.check,
                                      color: theme.primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 40,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(9.0),
                                    ),
                                    color: theme.primaryColorDark,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      ViceIcons.cart,
                                      color: theme.primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ));
                    },
                  ) : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
