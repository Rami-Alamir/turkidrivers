import 'package:flutter/material.dart';

class SolidLineConnector extends StatelessWidget {
  final Color color;

  const SolidLineConnector({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        width: 3,
        height: 50,
        color: color,
      ),
    );
  }
}
