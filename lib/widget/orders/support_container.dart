import 'dart:io';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/shared/main_container.dart';
import 'package:almaraa_drivers/widget/shared/rounded_rectangle_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportContainer extends StatelessWidget {
  final Order order;

  const SupportContainer({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 16, right: 8.0, bottom: 8, left: 8),
          child: Text(
            AppLocalizations.of(context)!.tr('support2'),
            style:
                Theme.of(context).textTheme.headline4?.copyWith(fontSize: 16),
          ),
        ),
        MainContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedRectangleButton(
                        title: 'contact_via_whatsapp',
                        width: SizeConfig.screenWidth! * 0.4,
                        height: 42,
                        fontSize: 14,
                        padding: EdgeInsets.only(top: 1),
                        onPressed: () {
                          launchWhatsAppLaunchWhatsApp(phone: '+966551616946');
                        }),
                    RoundedRectangleButton(
                        title: 'support',
                        fontSize: 14,
                        height: 42,
                        width: SizeConfig.screenWidth! * 0.4,
                        padding: EdgeInsets.only(top: 1),
                        onPressed: () {
                          String phoneUrl = 'tel:+966118280980';
                          _launchURL(phoneUrl);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> launchWhatsAppLaunchWhatsApp({
    required String phone,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse('${order.salesOrderId}')}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse('${order.salesOrderId}')}";
      }
    }

    _launchURL(url());
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  formatDecimal(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 3);
  }
}
