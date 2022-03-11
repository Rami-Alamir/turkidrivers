import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/networking/api_base_helper.dart';

class OrdersRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get orders list
  Future<Orders> getOrdersList(String driverId) async {
    print("getOrdersList");
    final queryParameters = {'driverid': driverId};
    final response =
        await _helper.get("/system/api/get-delivery-order", queryParameters);
    // print(response.toString());
    Orders? order;
    try {
      order = Orders.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return order!;
  }

  //change orders status
  Future<int> changeOrdersStatus(orderId, status, {notes}) async {
    print(notes);
    var body;
    if (notes != null && notes.toString().length > 0) {
      print('notes: $notes');
      body = {"salesOrderId": orderId, "status": status, "notes": notes};
    } else {
      body = {
        "salesOrderId": orderId,
        "status": status,
      };
    }
    final response =
        await _helper.put("/system/api/update-delivery-status", body);
    return response;
  }
}
