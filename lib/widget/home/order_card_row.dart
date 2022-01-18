import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';

class OrderCardRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? color;
  final Color? fontColor;
  const OrderCardRow(
      {required this.title,
      required this.subtitle,
      required this.icon,
      this.color = const Color.fromRGBO(90, 4, 9, 1),
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              AppLocalizations.of(context)!.tr(title),
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 12,
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: SizeConfig.screenWidth! * 0.7,
                ),
                child: Text(
                  subtitle,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: fontColor, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
