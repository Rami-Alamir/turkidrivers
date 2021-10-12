import 'package:flutter/material.dart';

class GetSColorByTime {
  Color? statusColor(int timeId, int orderStatus) {
    if ((orderStatus == 10) || (orderStatus == 12)) {
      switch (timeId) {
        case 0:
          return checkTime(11, 10, 12);
        case 1:
          return checkTime(14, 13, 15);
        case 2:
          return checkTime(17, 16, 18);
        case 3:
          return checkTime(19, 18, 20);
        case 4:
          return checkTime(22, 21, 23);
        default:
          return Colors.white;
      }
    } else
      return Colors.white;
  }

  Color? checkTime(int hour1, int hour2, int hour3) {
    int hour = DateTime.now().hour;
    print(hour <= hour1 && hour >= hour2);
    print(hour >= hour3);
    if (hour <= hour1 && hour >= hour2) {
      return Colors.yellow;
    } else if (hour >= hour3)
      return Colors.red;
    else
      return null;
  }
}
