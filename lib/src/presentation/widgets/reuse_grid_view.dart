import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReUseGridView extends StatelessWidget {
  final int itemCount;
  final Function() onRefresh;
  final RefreshController controller;
  final Widget Function(BuildContext context, int index) itemBuilder;
  const ReUseGridView({super.key,required this.itemCount, required this.itemBuilder, required this.onRefresh, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      header: const ClassicHeader(),
      onRefresh: onRefresh,
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 270,
          
        ),
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}