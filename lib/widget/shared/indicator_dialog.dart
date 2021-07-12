import 'package:flutter/material.dart';
import 'package:almaraa_drivers/widget/shared/spinkit_indicator.dart';

class IndicatorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
        color: Colors.transparent, child: Center(child: SpinkitIndicator()));
  }
}
