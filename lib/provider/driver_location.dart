import 'dart:async';
import 'package:almaraa_drivers/repository/tracking_repository.dart';
import 'package:almaraa_drivers/utilities/get_strings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as Location;

class DriverLocationProvider with ChangeNotifier {
  late int _driverId;
  Location.LocationData? _locationData;
  Location.Location _location = Location.Location();
  String _currentLocation = "";
  bool _isLoading = true;

  Location.LocationData? get locationData => _locationData;
  String get currentLocation => _currentLocation;

  set driverId(int value) {
    _driverId = value;
  }

  // get driver location
  Future<void> getCurrentLocation() async {
    print("getCurrentLocation");
    try {
      if (_isLoading) {
        print('dddsadas');
        _isLoading = false;
        _locationData = await _location.getLocation();
        setCurrentLocationDescription();
        updateDriverLocation();
        Timer(Duration(seconds: 60), () {
          _isLoading = true;
          notifyListeners();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // get driver location when changed
  Future<void> onLocationChanged() async {
    print('onLocationChanged');
    // _location.changeSettings(
    //     accuracy: Location.LocationAccuracy.high,
    //     interval: 60000,
    //     distanceFilter: 10);
    // _location.onLocationChanged.listen((Location.LocationData currentLocation) {
    //   print("onLocationChanged ${currentLocation.toString()}");
    //   _locationData = currentLocation;
    //   if (!_isLoading) setCurrentLocationDescription();
    // });
  }

  //update location in db
  Future<void> updateDriverLocation() async {
    try {
      await TrackingRepository().updateDriverLocation(
          '$_driverId',
          _locationData?.latitude.toString(),
          _locationData?.longitude.toString());
    } catch (e) {}
  }

  //get current location description
  Future<void> setCurrentLocationDescription() async {
    _isLoading = true;
    List<Placemark> placemark = await placemarkFromCoordinates(
        _locationData!.latitude!, _locationData!.longitude!,
        localeIdentifier: 'ar');
    Placemark place = placemark.first;
    _currentLocation = GetStrings().locationDescription(place);
    _isLoading = false;

    notifyListeners();
  }
}
