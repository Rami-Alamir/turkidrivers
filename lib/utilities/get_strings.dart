import 'dart:io';

import 'package:geocoding/geocoding.dart';

class GetStrings {
  String? deliveryTime(String time) {
    switch (time) {
      case 'الصبح':
        return 'morning_time';
      case "الظهر":
        return 'dhuhr_time';
      case "العصر":
        return 'asr_time';
      case "المغرب":
        return 'maghrib_time';
      case "العشاء":
        return 'isha_time';
      case "الفترة الصباحية":
        return 'morning_time';
      case "الفترة المسائية":
        return 'evening_time';
      default:
        return time;
    }
  }

  String? orderStatus(int code) {
    switch (code) {
      case 12:
        return 'problem_being_solved';
      case 9:
        return 'prepared';
      case 14:
        return 'delivered';
      case 16:
        return 'problem_being_solved_and_delivered';
      case 13:
        return 'problem_solved';
      case 6:
        return 'canceled';
      case 10:
        return 'on_way';
      default:
        return 'order_status';
    }
  }

  String locationDescription(Placemark place) {
    print("locationDescription");
    print(place);
    String description = "";
    if (Platform.isAndroid) {
      description =
          "${place.postalCode}${(place.subLocality?.trim().length ?? 0) > 0 ? " - " : ""}${place.subLocality}${(place.thoroughfare?.trim().length ?? 0) > 0 ? " - " : ""}${place.thoroughfare}";
      if (description.length == 0)
        description =
            "${place.administrativeArea}${(place.street?.trim().length ?? 0) > 0 ? " - " : ""}${place.street}";
    } else
      description =
          "${place.street}${(place.subLocality?.length ?? 0) > 0 ? " - " : ""}${place.subLocality}";
    return description;
  }
}
