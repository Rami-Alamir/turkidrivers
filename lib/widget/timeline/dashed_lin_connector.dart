import 'package:flutter/material.dart';

class DashedLineConnector extends StatelessWidget {
  final Color color;

  const DashedLineConnector({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 3,
            height: 13.33,
            color: color,
          ),
          Container(
            width: 3,
            height: 5,
            color: Colors.transparent,
          ),
          Container(
            width: 3,
            height: 13.33,
            color: color,
          ),
          Container(
            width: 3,
            height: 5,
            color: Colors.transparent,
          ),
          Container(
            width: 3,
            height: 13.33,
            color: color,
          ),
        ],
      ),
    );
  }
}
