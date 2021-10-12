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

  // get driver location and update location in db
  void getCurrentLocation() async {
    try {
      if (updateLocation) {
        _locationData = await Location().getLocation();
        updateDriverLocation();
        Timer(Duration(seconds: 60), () {
          updateLocation = true;
          notifyListeners();
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //used to get distance between driver and client
  double calculateDistance(double latitude, double longitude) {
    double distance = -1.000;
    getCurrentLocation();
    try {
      distance = Geolocator.distanceBetween(_locationData.latitude!,
              _locationData.longitude!, latitude, longitude) /
          1000;
    } catch (e) {}
    return distance;
  }

  Future<void> updateDriverLocation() async {
    updateLocation = false;
    try {
      await TrackingRepository().updateDriverLocation(
          '$_driverId',
          _locationData.latitude.toString(),
          _locationData.longitude.toString());
    } catch (e) {}
  }
}
