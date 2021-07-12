import 'package:flutter/material.dart';

class GetSColorByStatus {
  Color statusColor(int code) {
    switch (code) {
      case 6:
        return Colors.red;

      case 13:
      case 11:
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
