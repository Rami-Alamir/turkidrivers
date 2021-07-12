import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/driver_location.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/behavior.dart';
import 'package:almaraa_drivers/widget/orders/order_details_container.dart';
import 'package:almaraa_drivers/widget/orders/order_timeline.dart';
import 'package:almaraa_drivers/widget/orders/support_container.dart';
import 'package:almaraa_drivers/widget/shared/title_app_bar.dart';
import 'package:almaraa_drivers/widget/shared/turki_drawer.dart';

class OrderDetails extends StatefulWidget {
  final orderId;
  OrderDetails({@required this.orderId});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context);
    final _driverLocation =
        Provider.of<DriverLocationProvider>(context, listen: true);
    return Scaffold(
      drawer: TurkiDrawer(),
      appBar: AppBarWithTitle(
        title: AppLocalizations.of(context)!.tr('order_details'),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ScrollConfiguration(
          behavior: Behavior(),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: [
              OrderTimeline(
                status:
                    _orders.ordersData!.order![_orders.index].orderStatus!.id!,
              ),
              OrderDetailsContainer(
                  total: _orders.getTotal(),
                  status: _orders
                      .ordersData!.order![_orders.index].orderStatus!.id!,
                  order: _orders.ordersData!.order![_orders.index],
                  distance: _driverLocation.calculateDistance(
                      _orders.ordersData?.order?[_orders.index].deliveryAddress
                              ?.latitude ??
                          0,
                      _orders.ordersData?.order?[_orders.index].deliveryAddress
                              ?.longitude ??
                          0)),
              SupportContainer(
                order: _orders.ordersData!.order![_orders.index],
              )
            ],
          ),
        ),
      ),
    );
  }
}
