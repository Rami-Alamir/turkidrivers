import 'package:flutter/material.dart';
import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/repository/orders_repository.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';

class OrdersProvider with ChangeNotifier {
  bool init = true;
  bool _isLoading = true;
  bool _retry = false;
  OrderData? _ordersData;
  bool get isLoading => _isLoading;
  bool get retry => _retry;
  late int _index;
  late int _orderId;
  OrderData? get ordersData => _ordersData;
  int _radioValue = -1;
  late BuildContext _context;
  int get radioValue => _radioValue;

  set radioVal(int value) {
    _radioValue = value;
    notifyListeners();
  }

  int get index => _index;

  set setIndex(int value) {
    _index = value;
    _orderId = _ordersData!.order![_index].id!;
  }

  int get orderId => _orderId;

  // get orders data
  Future<void> getOrdersData(
      {required String userId, required BuildContext context}) async {
    _context = context;
    try {
      _ordersData = await OrdersRepository().getOrdersList(userId);
    } catch (e) {
      _retry = true;
      print('error:  ${e.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> changeOrderStatus() async {
    int statusCode = 404;
    try {
      statusCode = await OrdersRepository()
          .changeOrdersStatus(orderId.toString(), _radioValue.toString());
    } catch (e) {
      _retry = true;
      print('error:  ${e.toString()}');
    }
    if (statusCode == 200) {
      ordersData!.order![_index].orderStatus!.id = radioValue;
      if (radioValue == 6 || radioValue == 11 || radioValue == 13)
        ordersData!.remainingOrders = ordersData!.remainingOrders! - 1;
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
  } // re-init orders data

  Future<void> sortOrdersList() async {
    try {
      if (_ordersData?.order != null)
        _ordersData?.order!.sort((a, b) => a.deliveryAddress!.distance!
            .compareTo(b.deliveryAddress!.distance!));
    } catch (e) {
      print("rami ${e.toString()}");
    }
  }

  double getTotal() {
    print('getTotal');
    double total = 0.0;
    total = ((_ordersData!.order![_index].payment?.price) ?? 0.0) -
        ((_ordersData!.order![_index].payment?.paid) ?? 0.0) -
        ((_ordersData!.order![_index].payment?.amountDisc) ?? 0.0) -
        ((_ordersData!.order![_index].payment!.price!) *
            (_ordersData!.order![_index].payment!.discount! / 100));
    return total;
  }

  void clear() {
    _isLoading = true;
    _retry = false;
    _ordersData = null;
  }
}
