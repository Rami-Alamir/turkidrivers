import 'package:almaraa_drivers/widget/shared/order_card_row.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/get_color_by_status.dart';
import 'package:almaraa_drivers/utilities/get_strings.dart';
import 'package:almaraa_drivers/utilities/ra7_icons.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/shared/main_container.dart';
import 'package:almaraa_drivers/widget/shared/rounded_rectangle_button.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsContainer extends StatelessWidget {
  final Order order;
  final double distance;
  final int status;
  final int quantity;
  final double total;
  const OrderDetailsContainer(
      {required this.order,
      required this.distance,
      required this.quantity,
      required this.status,
      required this.total});

  @override
  Widget build(BuildContext context) {
    final String statusStr =
        (GetStrings().orderStatus(int.parse(order.statusId!))!) ==
                'order_status'
            ? order.status!
            : AppLocalizations.of(context)!
                .tr((GetStrings().orderStatus(int.parse(order.statusId!))!));
    return MainContainer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.tr('order_details'),
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // Visibility(
                  //     visible: int.parse(order.latitude!) > 1.0,
                  //     child: Text(
                  //       distance < 1
                  //           ? '${(formatDecimal(distance)).toString().substring(2)}m'
                  //           : '${formatDecimal(distance)}km',
                  //       style: Theme.of(context).textTheme.headline4,
                  //     )),
                ],
              ),
            ),
            OrderCardRow(
              title: 'customer_name',
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
                  fontColor: Theme.of(context).textTheme.headline1?.color!,
                  subtitle: order.address ?? "",
                  icon: RA7ICONS.location),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: (order.deliveryTime != null),
                  child: SizedBox(
                    width: SizeConfig.screenWidth! * 0.5,
                    child: OrderCardRow(
                        title: 'delivery_time',
                        fontColor: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.color!,
                        subtitle:
                            GetStrings().deliveryTime(order.deliveryTime!)! ==
                                    order.deliveryTime!
                                ? order.deliveryTime!
                                : AppLocalizations.of(context)!.tr(GetStrings()
                                    .deliveryTime(order.deliveryTime!)!),
                        icon: RA7ICONS.clock),
                  ),
                ),
                OrderCardRow(
                    title: 'number_of_boxes',
                    fontColor: Theme.of(context).textTheme.headline1?.color!,
                    subtitle: quantity.toString(),
                    icon: RA7ICONS.order),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: (order.deliveryTime != null),
                  child: SizedBox(
                    width: SizeConfig.screenWidth! * 0.5,
                    child: OrderCardRow(
                        title: 'amount_to_be_collected',
                        fontColor:
                            Theme.of(context).textTheme.headline1?.color!,
                        subtitle:
                            '${total >= 0 ? total : 0} ${AppLocalizations.of(context)!.tr('sr')}',
                        icon: RA7ICONS.dollar_circle),
                  ),
                ),
                OrderCardRow(
                    title: 'order_status',
                    fontColor: GetSColorByStatus()
                        .statusColor(int.parse(order.statusId!)),
                    subtitle: statusStr,
                    color: GetSColorByStatus()
                        .statusColor(int.parse(order.statusId!)),
                    icon: RA7ICONS.truck_delivered),
              ],
            ),
            Visibility(
              visible: order.notes.toString() != "",
              child: OrderCardRow(
                title: 'notes',
                subtitle: order.notes.toString(),
                icon: RA7ICONS.sticky_notes,
                fontColor: Theme.of(context).textTheme.headline1?.color!,
              ),
            ),
            Visibility(
              visible: (status != 6) && (status != 14) && (status != 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedRectangleButton(
                      title: 'contact_customer',
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child:
                            Icon(RA7ICONS.phone, size: 15, color: Colors.white),
                      ),
                      fontSize: 14,
                      height: 50,
                      width: SizeConfig.screenWidth! * 0.84,
                      padding: EdgeInsets.only(top: 40),
                      onPressed: () {
                        String phoneUrl = 'tel://${order.phone}';
                        _launchURL(phoneUrl);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  formatDecimal(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 3);
  }
}
