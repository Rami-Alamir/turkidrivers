import 'dart:async';
import 'package:almaraa_drivers/repository/tracking_repository.dart';
import 'package:almaraa_drivers/utilities/get_strings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as Location;

class DriverLocationProvider with ChangeNotifier {
  DriverLocationProvider() {
    print('DriverLocationProvider');
    getCurrentLocation();
  }

  late int _driverId;
  Location.LocationData? _locationData;
  String _currentLocation = "";
  bool updateLocation = true;

  Location.LocationData? get locationData => _locationData;
  String get currentLocation => _currentLocation;

  set driverId(int value) {
    _driverId = value;
  }

  // get driver location
  void getCurrentLocation() async {
    print("getCurrentLocation");
    if (_locationData == null)
      try {
        _locationData = await Location.Location().getLocation();
        print("currentLocation ${_locationData.toString()}");
      } catch (e) {
        print(e.toString());
      }

    Location.Location()
        .onLocationChanged
        .listen((Location.LocationData currentLocation) {
      print("onLocationChanged ${currentLocation.toString()}");
      _locationData = currentLocation;
    });

    // try {
    //   if (updateLocation) {
    //     _locationData = await Location().getLocation();
    //     updateDriverLocation();
    //     Timer(Duration(seconds: 60), () {
    //       updateLocation = true;
    //       notifyListeners();
    //     });
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }
    setCurrentLocationDescription();
  }

  //update location in db
  Future<void> updateDriverLocation() async {
    updateLocation = false;
    try {
      await TrackingRepository().updateDriverLocation(
          '$_driverId',
          _locationData?.latitude.toString(),
          _locationData?.longitude.toString());
    } catch (e) {}
  }

  //get current location description
  Future<void> setCurrentLocationDescription() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        _locationData!.latitude!, _locationData!.longitude!,
        localeIdentifier: 'ar');
    Placemark place = placemark.first;
    _currentLocation = GetStrings().locationDescription(place);
    notifyListeners();
  }
}
