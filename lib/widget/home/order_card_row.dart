import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';

class OrderCardRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? fontColor;
  const OrderCardRow(
      {required this.title, required this.icon, required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
            child: Icon(
              icon,
            ),
          ),
          Container(
            width: SizeConfig.screenWidth! * 0.7,
            child: Text(
              title,
              overflow: TextOverflow.visible,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: fontColor, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
