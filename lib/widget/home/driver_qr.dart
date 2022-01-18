import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DriverQr extends StatelessWidget {
  final String id;
  final double size;
  final Color color;

  const DriverQr(
      {required this.id, required this.size, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QrImage(
          data: id,
          version: QrVersions.auto,
          size: size,
          foregroundColor: color,
        ),
      ],
    );
  }
}
