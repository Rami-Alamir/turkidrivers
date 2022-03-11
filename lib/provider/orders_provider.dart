import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/models/order.dart';
import 'package:almaraa_drivers/repository/orders_repository.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class OrdersProvider with ChangeNotifier {
  TextEditingController noteController = TextEditingController();

  //used to hide/show drawer
  final AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();

  bool init = true;
  bool _isLoading = true;
  bool _retry = false;
  Orders? _ordersData;
  late int _index;
  late int _orderId;
  int _radioValue = -1;
  late BuildContext _context;
  int _remainingOrders = 0;
  int _selected = -1;
  LocationData? _locationData;
  Orders? get ordersData => _ordersData;
  int get radioValue => _radioValue;
  bool get isLoading => _isLoading;
  bool get retry => _retry;
  int get selected => _selected;
  int get remainingOrders => _remainingOrders;
  int get index => _index;
  int get orderId => _orderId;

  set setSelected(int value) {
    _selected = value;
  }

  set radioVal(int value) {
    _radioValue = value;
    notifyListeners();
  }

  set setIndex(int value) {
    _index = value;
    _orderId = int.parse(_ordersData!.data![_index].salesOrderId!);
  }

  // get orders data
  Future<void> getOrdersData(
      {required String userId, required BuildContext context}) async {
    _context = context;
    try {
      _ordersData = await OrdersRepository().getOrdersList(userId);
      getRemainingOrders();
      sortOrdersList();
    } catch (e) {
      _retry = true;
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  //calculate remaining orders
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

  // chang order status
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
        if (status == 6 || status == 14 || status == 16) _remainingOrders -= 1;
        if (ordersData!.data![_index].salesOrderId == id)
          ordersData!.data![_index].statusId = status.toString();
        else {
          for (int i = 0; i < _ordersData!.data!.length; i++) {
            if (ordersData!.data![i].salesOrderId == id) {
              ordersData!.data![i].statusId = status.toString();
              break;
            }
          }
        }
      } catch (e) {}
      notifyListeners();
      AlertController.show(
          "",
          AppLocalizations.of(_context)!.tr('status_updated_successfully'),
          TypeAlert.success);
    } else
      AlertController.show(
          "",
          AppLocalizations.of(_context)!.tr('unexpected_error'),
          TypeAlert.error);
  }

  // re-init orders data
  Future<void> reInitOrdersData({required String userId}) async {
    _isLoading = true;
    notifyListeners();
    await getOrdersData(context: _context, userId: userId);
  }

  // sort order by distance between driver and clients
  Future<void> sortOrdersList() async {
    try {
      print('sortOrdersList');
      print('$_locationData');
      for (int i = 0; i < (_ordersData?.data?.length ?? 0); i++) {
        final Order order = _ordersData!.data![i];
        if (int.parse(order.statusId!) == 6 ||
            int.parse(order.statusId!) == 14 ||
            int.parse(order.statusId!) == 16)
          order.distance = 1000000.0;
        else
          order.distance = calculateDistance(
              double.parse(order.latitude!), double.parse(order.longitude!));
      }
      if (_ordersData?.data != null)
        _ordersData?.data!.sort((a, b) => a.distance.compareTo(b.distance));
    } catch (e) {}
    notifyListeners();
  }

  //used to get distance between driver and client
  double calculateDistance(double latitude, double longitude) {
    double distance = -1.0;
    if (_locationData != null)
      try {
        distance = Geolocator.distanceBetween(_locationData!.latitude!,
                _locationData!.longitude!, latitude, longitude) /
            1000;
      } catch (e) {
        print(e.toString());
      }
    return distance;
  }

  //get order remaining balance
  double getTotal() {
    double total = 0.0;
    for (int i = 0; i < _ordersData!.data![index].fulfill!.length; i++)
      total += _ordersData!.data![index].fulfill![i].remaining!;
    return total;
  }

  //get order quantity
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

  //update Location data then sort orders
  void updateLocationData({LocationData? locationData}) {
    _locationData = locationData;
    if (_locationData != null) sortOrdersList();
  }

  void clear() {
    _isLoading = true;
    _retry = false;
    _ordersData = null;
  }
}
