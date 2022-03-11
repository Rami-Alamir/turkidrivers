import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/get_color_by_status.dart';
import 'package:almaraa_drivers/utilities/get_strings.dart';
import 'package:almaraa_drivers/utilities/ra7_icons.dart';
import 'package:almaraa_drivers/widget/shared/main_container.dart';
import '../../utilities/size_config.dart';
import '../shared/order_card_row.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final int index;

  const OrderCard({required this.order, required this.index});
  @override
  Widget build(BuildContext context) {
    final double _maxWidth = SizeConfig.screenWidth! * 0.7;

    final String status =
        (GetStrings().orderStatus(int.parse(order.statusId!))!) ==
                'order_status'
            ? order.status!
            : AppLocalizations.of(context)!
                .tr((GetStrings().orderStatus(int.parse(order.statusId!))!));
    return InkWell(
      onTap: () {
        final _orders = Provider.of<OrdersProvider>(context, listen: false);
        _orders.setIndex = index;
        Navigator.of(context).pushNamed('/OrderDetails');
      },
      child: MainContainer(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.tr('order_id'),
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                        child: Text(
                          '${order.salesOrderId}',
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: order.distance < 1000000.0,
                    child: Text(
                      getDistance(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ),
            OrderCardRow(
              title: 'customer_name',
              maxWidth: _maxWidth,
              subtitle: order.customerName!,
              icon: RA7ICONS.profile,
              fontColor: Theme.of(context).textTheme.headline1?.color!,
            ),
            Visibility(
              visible: order.address != null
                  ? (order.address != '' ? true : false)
                  : false,
              child: OrderCardRow(
                  title: 'address',
                  maxWidth: _maxWidth,
                  fontColor: Theme.of(context).textTheme.headline1?.color!,
                  subtitle: order.address ?? "",
                  icon: RA7ICONS.location),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: (order.deliveryTime != null),
                  child: OrderCardRow(
                      title: 'delivery_time',
                      maxWidth: _maxWidth,
                      fontColor: Theme.of(context).textTheme.headline1?.color!,
                      subtitle: GetStrings()
                                  .deliveryTime(order.deliveryTime!)! ==
                              order.deliveryTime!
                          ? order.deliveryTime!
                          : AppLocalizations.of(context)!.tr(
                              GetStrings().deliveryTime(order.deliveryTime!)!),
                      icon: RA7ICONS.clock),
                ),
                OrderCardRow(
                    title: 'order_status',
                    maxWidth: _maxWidth,
                    fontColor: GetSColorByStatus()
                        .statusColor(int.parse(order.statusId!)),
                    subtitle: status,
                    color: GetSColorByStatus()
                        .statusColor(int.parse(order.statusId!)),
                    icon: RA7ICONS.truck_delivered),
              ],
            ),
          ],
        ),
      )),
    );
  }

  formatDecimal(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 3);
  }

  String getDistance() {
    return order.distance < 1
        ? '${(formatDecimal(order.distance))?.toString().length}m'
        : '${formatDecimal(order.distance)}km';
  }
}
