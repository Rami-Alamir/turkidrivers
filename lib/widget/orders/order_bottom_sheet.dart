import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/get_color_by_status.dart';
import 'package:almaraa_drivers/utilities/get_strings.dart';
import 'package:almaraa_drivers/utilities/ra7_icons.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/shared/order_card_row.dart';
import 'package:almaraa_drivers/widget/shared/rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderBottomSheet extends StatelessWidget {
  final Order order;
  final double total;

  const OrderBottomSheet({required this.order, required this.total});

  @override
  Widget build(BuildContext context) {
    final String statusStr =
        (GetStrings().orderStatus(int.parse(order.statusId!)) == 'order_status'
            ? 'order_status'
            : AppLocalizations.of(context)!
                .tr((GetStrings().orderStatus(int.parse(order.statusId!))!)));
    return Container(
      height: 110,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: int.parse(order.statusId!) == 6 ||
              int.parse(order.statusId!) == 14 ||
              int.parse(order.statusId!) == 16
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  statusStr,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: GetSColorByStatus()
                          .statusColor(int.parse(order.statusId!))),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      child: OrderCardRow(
                          maxWidth: SizeConfig.screenWidth! * 07,
                          title: 'amount_to_be_collected',
                          fontColor:
                              Theme.of(context).textTheme.headline1?.color!,
                          fontSize: 16,
                          subtitle:
                              '$total ${AppLocalizations.of(context)!.tr('sr')}',
                          icon: RA7ICONS.dollar_circle),
                    ),
                  ],
                ),
                // Visibility(
                Visibility(
                  //   visible: double.parse(order.latitude!) > 1.0,
                  visible: true,
                  child: RoundedRectangleButton(
                      title: 'map',
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child:
                            Icon(RA7ICONS.map, size: 15, color: Colors.white),
                      ),
                      width: SizeConfig.screenWidth! - 180,
                      height: 50,
                      fontSize: 14,
                      padding: EdgeInsets.only(bottom: 1),
                      onPressed: () {
                        String googleUrl =
                            'https://www.google.com/maps/search/?api=1&query=${order.latitude!},${order.longitude!}';
                        _launchURL(googleUrl);
                      }),
                ),
              ],
            ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
