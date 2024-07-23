import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/models/order_model.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DeliveryPage extends StatelessWidget {
  final OrderModel orderModel;
  const DeliveryPage({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              name: 'Delivery',
              showBack: true,
              showColor: false,
              showCart: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BarcodeWidget(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: 100,
                  data: orderModel.id,
                  barcode: Barcode.qrCode(),
                  color: theme.primaryColorDark,
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Id   : #${orderModel.id}",
                      style: AppStyle.normalStyle,
                    ),
                    Text(
                      "Amount   :  ${orderModel.totalAmt}",
                      style: AppStyle.normalStyle,
                    ),
                    Text(
                      "Quantity  :  ${orderModel.totalQty}",
                      style: AppStyle.normalStyle,
                    ),
                    Text(
                      "Status      :  ${orderModel.approve}",
                      style: AppStyle.normalStyle,
                    ),
                  ],
                ),
              ],
            ),
            const Gap(40),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Order Status",
                  style: AppStyle.titleStyle,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    MyTimelineTile(
                      isFirst: true,
                      isLast: false,
                      isPast: true,
                      title: "Order Placed",
                      timestamp: orderModel.timestamp!.toDate().toString(),
                      iconData: Iconsax.clipboard,
                    ),
                    MyTimelineTile(
                      isFirst: false,
                      isLast: false,
                      isPast: true,
                      title: "In Progress",
                      timestamp: orderModel.timestamp!.toDate().toString(),
                      iconData: Iconsax.paintbucket,
                    ),
                    MyTimelineTile(
                      isFirst: false,
                      isLast: true,
                      isPast: false,
                      title: "Packaged",
                      timestamp: orderModel.timestamp!.toDate().toString(),
                      iconData: Iconsax.check,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String timestamp;
  final IconData iconData;
  const MyTimelineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.title,
      required this.timestamp,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
            color: isPast
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColorDark.withOpacity(.2)),
        indicatorStyle: isPast
            ? IndicatorStyle(
                color: Theme.of(context).primaryColorDark,
                width: 30,
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ))
            : const IndicatorStyle(
                color: Color.fromARGB(255, 192, 185, 185),
                width: 30,
              ),
        alignment: TimelineAlign.start,
        endChild: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyle.normalStyle,
                  ),
                  Text(
                    timestamp,
                    style: AppStyle.descStyle,
                  ),
                ],
              ),
              const Spacer(),
              Icon(iconData),
            ],
          ),
        ),
      ),
    );
  }
}
