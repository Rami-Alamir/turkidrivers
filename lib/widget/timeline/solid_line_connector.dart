import 'package:flutter/material.dart';

class SolidLineConnector extends StatelessWidget {
  final Color color;

  const SolidLineConnector({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 3,
        height: 55,
        color: color,
      ),
    );
  }
}
