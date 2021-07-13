import 'dart:async';
import 'package:almaraa_drivers/repository/tracking_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class DriverLocationProvider with ChangeNotifier {
  DriverLocationProvider() {
    getCurrentLocation();
  }
  late int _driverId;
  late LocationData _locationData;
  bool updateLocation = true;
  set driverId(int value) {
    _driverId = value;
  }

  void getCurrentLocation() async {
    print('get location');
    try {
      if (updateLocation) {
        _locationData = await Location().getLocation();
        updateDriverLocation();
        Timer(Duration(seconds: 60), () {
          updateLocation = true;
          notifyListeners();
          print('55555555');
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  double calculateDistance(double latitude, double longitude) {
    double distance = -1.000;
    getCurrentLocation();
    try {
      distance = Geolocator.distanceBetween(_locationData.latitude!,
              _locationData.longitude!, latitude, longitude) /
          1000;
    } catch (e) {
      print(e.toString());
    }
    return distance;
  }

  Future<void> updateDriverLocation() async {
    updateLocation = false;
    int statusCode = 404;
    try {
      statusCode = await TrackingRepository().updateDriverLocation(
          '$_driverId',
          _locationData.latitude.toString(),
          _locationData.longitude.toString());
    } catch (e) {
      print('error:  ${e.toString()}');
    }
    if (statusCode == 200) {
      print('200');
    } else
      print('500');
  }
}
