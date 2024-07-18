import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/core/state_management/bloc/product_info/product_info_bloc.dart';
import 'package:shop_init/src/presentation/views/products/widgets/product_view.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';
import 'package:shop_init/src/presentation/widgets/reuse_grid_view.dart';
import 'package:shop_init/src/presentation/widgets/skeleton.dart';

class CategorizedProductScreen extends StatelessWidget {
  
  CategorizedProductScreen({super.key});
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
     
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              showCart: true,
              name: categoryName.toUpperCase(),
              showBack: true,
              showColor: false,
            ),
            Expanded(
              child: BlocProvider(
                create: (context) => ProductInfoBloc()..add(LoadProduct()),
                child: BlocBuilder<ProductInfoBloc, ProductInfoState>(
                  builder: (context, state) {
                    if (state is ProductInfoInitial) {
                      return const SkeletonCondition();
                    } else if (state is ProductInfoLoading) {
                      return const SkeletonCondition();
                    } else if (state is ProductInfoSuccess) {
                      final productInfo = state.products;
                      if (productInfo.isNotEmpty) {
                        return ReUseGridView(
                          controller: refreshController,
                          onRefresh: () {
                            BlocProvider.of<ProductInfoBloc>(context)
                                .add(LoadProduct());
                            refreshController.refreshCompleted();
                          },
                          itemCount: productInfo.length,
                          itemBuilder: (context, index) {
                            return ProductDesign(productModel: productInfo[index]);
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No Products Currently'),
                        );
                      }
                    } else {
                      return Text(state.props.toString());
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
