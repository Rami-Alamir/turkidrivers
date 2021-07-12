import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final Color borderColor;
  final Color fillColor;

  const DotIndicator({required this.borderColor, required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: borderColor, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
