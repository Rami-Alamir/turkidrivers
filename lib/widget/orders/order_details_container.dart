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
import 'order_details_row.dart';

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
    print('dddd' + '${order.deliveryAddress!.address}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 8, left: 8),
          child: Text(
            AppLocalizations.of(context)!.tr('order_details'),
            style:
                Theme.of(context).textTheme.headline4?.copyWith(fontSize: 16),
          ),
        ),
        MainContainer(
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
                        '${order.id}#',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(fontSize: 18),
                      ),
                      Visibility(
                          visible: order.deliveryAddress!.latitude! > 1.0,
                          child: Text(
                            distance < 1
                                ? '${(formatDecimal(distance)).toString().substring(2)}m'
                                : '${formatDecimal(distance)}km',
                            style: Theme.of(context).textTheme.headline4,
                          )),
                    ],
                  ),
                ),
                OrderDetailsRow(title: order.user!.name!, icon: RA7ICONS.user2),
                Visibility(
                  visible: (order.deliveryAddress?.address != null),
                  child: OrderDetailsRow(
                      title: order.deliveryAddress?.address ?? "",
                      icon: RA7ICONS.pin),
                ),
                OrderDetailsRow(
                    title: AppLocalizations.of(context)!
                        .tr(GetStrings().deliveryTime(order.orderTime!)!),
                    icon: RA7ICONS.clock),
                OrderDetailsRow(
                    title:
                        '${total >= 0 ? total : 0} ${AppLocalizations.of(context)!.tr('sr')}',
                    icon: RA7ICONS.cash),
                OrderDetailsRow(title: quantity.toString(), icon: RA7ICONS.box),
                OrderDetailsRow(
                    fontColor:
                        GetSColorByStatus().statusColor(order.orderStatus!.id!),
                    title: AppLocalizations.of(context)!
                        .tr(GetStrings().orderStatus(order.orderStatus!.id!)!),
                    icon: RA7ICONS.truck),
                Visibility(
                  visible: (status != 6) && (status != 11) && (status != 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedRectangleButton(
                          title: 'map',
                          width: SizeConfig.screenWidth! * 0.4,
                          height: 42,
                          fontSize: 14,
                          padding: EdgeInsets.only(top: 40),
                          onPressed: () {
                            // ShowConfirmDialog().confirmDialog(
                            //     context,
                            //     'Do_you_really_want_to_deliver',
                            //     '/DeliveryAddresses');
                            String googleUrl =
                                'https://www.google.com/maps/search/?api=1&query=${order.deliveryAddress?.latitude!},${order.deliveryAddress?.longitude!}';
                            _launchURL(googleUrl);
                          }),
                      RoundedRectangleButton(
                          title: 'contact_customer',
                          fontSize: 14,
                          height: 42,
                          width: SizeConfig.screenWidth! * 0.4,
                          padding: EdgeInsets.only(top: 40),
                          onPressed: () {
                            String phoneUrl =
                                'tel://${order.user?.email!.toString().split('@')[0]}';
                            _launchURL(phoneUrl);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  formatDecimal(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 3);
  }
}
