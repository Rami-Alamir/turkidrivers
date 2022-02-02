import 'package:almaraa_drivers/widget/orders/order_bottom_sheet.dart';
import 'package:almaraa_drivers/widget/orders/order_details_container.dart';
import 'package:almaraa_drivers/widget/orders/support_container.dart';
import 'package:almaraa_drivers/widget/orders/order_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/driver_location.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/behavior.dart';
import 'package:almaraa_drivers/widget/shared/title_app_bar.dart';
import 'package:almaraa_drivers/widget/shared/turki_drawer.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context);
    final double _total = _orders.getTotal();

    final _driverLocation =
        Provider.of<DriverLocationProvider>(context, listen: true);
    return Scaffold(
      drawer: TurkiDrawer(),
      appBar: AppBarWithTitle(
        title: AppLocalizations.of(context)!.tr('order_details'),
      ),
      bottomSheet: OrderBottomSheet(
          order: _orders.ordersData!.data![_orders.index], total: _total),
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
                salesOrderId:
                    _orders.ordersData!.data![_orders.index].salesOrderId!,
                status: int.parse(
                    _orders.ordersData!.data![_orders.index].statusId!),
              ),
              OrderDetailsContainer(
                quantity: _orders.getQuantity(),
                total: _total,
                status: int.parse(
                    _orders.ordersData!.data![_orders.index].statusId!),
                order: _orders.ordersData!.data![_orders.index],
                distance: 0,
              ),
              SupportContainer(
                order: _orders.ordersData!.data![_orders.index],
              ),
              Padding(padding: EdgeInsets.only(bottom: 110))
            ],
          ),
        ),
      ),
    );
  }
}
