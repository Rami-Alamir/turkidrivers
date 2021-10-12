import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/repository/orders_repository.dart';

class OrdersProvider with ChangeNotifier {
  TextEditingController noteController = TextEditingController();

  bool init = true;
  bool _isLoading = true;
  bool _retry = false;
  Orders? _ordersData;
  bool get isLoading => _isLoading;
  bool get retry => _retry;
  late int _index;
  late int _orderId;
  Orders? get ordersData => _ordersData;
  int _radioValue = -1;
  late BuildContext _context;
  int get radioValue => _radioValue;
  int _remainingOrders = 0;

  int get remainingOrders => _remainingOrders;

  set radioVal(int value) {
    _radioValue = value;
    notifyListeners();
  }

  int get index => _index;

  set setIndex(int value) {
    _index = value;
    _orderId = int.parse(_ordersData!.data![_index].salesOrderId!);
  }

  int get orderId => _orderId;

  // get orders data
  Future<void> getOrdersData(
      {required String userId, required BuildContext context}) async {
    _context = context;
    try {
      _ordersData = await OrdersRepository().getOrdersList(userId);
      getRemainingOrders();
    } catch (e) {
      _retry = true;
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  int getRemainingOrders() {
    _remainingOrders = 0;
    for (int i = 0; i < _ordersData!.data!.length; i++) {
      if (int.parse(_ordersData!.data![i].statusId!) == 14 ||
          int.parse(_ordersData!.data![i].statusId!) == 6 ||
          int.parse(_ordersData!.data![i].statusId!) == 16) {
        continue;
      } else {
        _remainingOrders += 1;
      }
    }
    return _remainingOrders;
  }

  Future<void> changeOrderStatus(String id, int status) async {
    int statusCode = 404;
    try {
      if (status == 12)
        statusCode = await OrdersRepository().changeOrdersStatus(
            id, status.toString(),
            notes: noteController.text);
      else
        statusCode =
            await OrdersRepository().changeOrdersStatus(id, status.toString());
    } catch (e) {
      print(e.toString());
      _retry = true;
    }
    if (statusCode == 200) {
      try {
        print('${ordersData!.data![_index].salesOrderId} == $id}');
        if (status == 6 || status == 14 || status == 16) _remainingOrders -= 1;
        if (ordersData!.data![_index].salesOrderId == id)
          ordersData!.data![_index].statusId = status.toString();
        else {
          print('else');
          for (int i = 0; i < _ordersData!.data!.length; i++) {
            if (ordersData!.data![i].salesOrderId == id) {
              ordersData!.data![i].statusId = status.toString();
              break;
            }
          }
        }
      } catch (e) {}

      notifyListeners();
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
          content: Text(
        AppLocalizations.of(_context)!.tr('status_updated_successfully'),
        textAlign: TextAlign.center,
      )));
    } else
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
          content: Text(
        AppLocalizations.of(_context)!.tr('unexpected_error'),
        textAlign: TextAlign.center,
      )));
  }

  // re-init orders data
  Future<void> reInitOrdersData({required String userId}) async {
    _isLoading = true;
    notifyListeners();
    await getOrdersData(context: _context, userId: userId);
  }

  // sort order by distance between driver and clients
  // Future<void> sortOrdersList() async {
  //   // try {
  //   // //   if (_ordersData?.order != null)
  //   // //     _ordersData?.data!.sort((a, b) => a.deliveryAddress!.distance!
  //   //         .compareTo(b.deliveryAddress!.distance!));
  //   // } catch (e) {}
  // }

  //get order remaining balance
  double getTotal() {
    double total = 0.0;
    for (int i = 0; i < _ordersData!.data![index].fulfill!.length; i++)
      total += _ordersData!.data![index].fulfill![i].remaining!;
    return total;
  }

  int getQuantity() {
    int quantity = 0;
    for (int i = 0; i < _ordersData!.data![index].fulfill!.length; i++) {
      for (int j = 0;
          j < _ordersData!.data![index].fulfill![i].items!.length;
          j++)
        quantity +=
            _ordersData!.data![index].fulfill![i].items![j].boxesNumber!;
    }
    return quantity == 0 ? 1 : quantity;
  }

  void clear() {
    _isLoading = true;
    _retry = false;
    _ordersData = null;
  }
}
