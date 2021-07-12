import 'package:almaraa_drivers/networking/api_base_helper.dart';

class TrackingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //update driver location
  Future<int> updateDriverLocation(driverId, lat, lng) async {
    final body = {
      'user_id': driverId,
      'lat': lat,
      'lng': lng,
    };
    final response =
        await _helper.post2("/system/api/DriverCurrentLocation", body);
    return response;
  }
}
