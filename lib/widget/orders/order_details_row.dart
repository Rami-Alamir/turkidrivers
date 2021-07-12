import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';

class OrderDetailsRow extends StatelessWidget {
  final String title;
  final Color fontColor;

  final IconData icon;
  const OrderDetailsRow(
      {required this.title, required this.icon, this.fontColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          Container(
            width: SizeConfig.screenHeight! * 0.3,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: fontColor),
            ),
          ),
        ],
      ),
    );
  }
}
