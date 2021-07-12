import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/networking/api_base_helper.dart';

class OrdersRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get orders list
  Future<OrderData> getOrdersList(String driverId) async {
    print("getOrdersList");
    final queryParameters = {'driver_id': driverId};
    final response =
        await _helper.get("/system/api/order_drivers", queryParameters);
    return OrderData.fromJson(response);
  }

  //change orders status
  Future<int> changeOrdersStatus(orderId, status) async {
    final body = {'order_status_id': status};
    final response = await _helper.post2("/system/api/status/$orderId", body);
    return response;
  }
}
