import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final Color borderColor;
  final Color fillColor;
  final double shadowRadius;

  const DotIndicator(
      {required this.borderColor,
      required this.fillColor,
      this.shadowRadius = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: fillColor.withOpacity(0.2),
                spreadRadius: shadowRadius,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: fillColor,
            border: Border.all(color: borderColor, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
