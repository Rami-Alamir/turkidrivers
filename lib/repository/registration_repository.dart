import 'package:almaraa_drivers/models/user.dart';
import 'package:almaraa_drivers/networking/api_base_helper.dart';

class RegistrationRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  // login
  Future<User> login(var body) async {
    final response = await _helper.post("/system/api/driver/login", body);
    return User.fromJson(response);
  }
}
