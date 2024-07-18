import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/core/models/item_model.dart';
import 'package:shop_init/src/core/state_management/bloc/product_info/product_info_bloc.dart';
import 'package:shop_init/src/presentation/views/products/widgets/product_view.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';
import 'package:shop_init/src/presentation/widgets/reuse_grid_view.dart';
import 'package:shop_init/src/presentation/widgets/skeleton.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    categoryName = 'favorites';
  }

  RefreshController controller = RefreshController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(
            showCart: true,
            isAnimated: false,
            showDefinedName: true,
            name: 'Wishlist',
            showBack: false,
            showColor: false,
            showSearchBar: false,
          ),
          Expanded(
            child: StreamBuilder(
              stream: wishListRef.snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return const SkeletonCondition();
                }
                else if(snapshot.hasError){
                  return const SkeletonCondition();
                }
                else{
                  final productList = snapshot.data!.docs;
                    if (productList.isNotEmpty) {
                      
                      return ReUseGridView(
                        controller: controller,
                        onRefresh: () {
                         context.read<ProductInfoBloc>().add(LoadProduct());
                          controller.refreshCompleted();
                        },
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          final productModel = ItemModel.fromJson(productList[index].data());
                          return ProductDesign(
                              productModel: productModel);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No Favorites Currently'),
                      );
                    }
                }
              },
            )
          ),
        ],
      ),
    );
  }
}

// ReUseGridView(
//             controller: controller,
//             onRefresh: (){
//               controller.refreshCompleted();
//             },
//             itemCount: data!.length,
//             itemBuilder: (context, index) {
//               final productModel = data[index] ;
//               return Text(productModel.id);
//             },
//           );