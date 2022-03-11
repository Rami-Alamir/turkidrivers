import 'package:almaraa_drivers/widget/home/driver_app_bar.dart';
import 'package:almaraa_drivers/widget/home/location_card.dart';
import 'package:almaraa_drivers/widget/shared/background.dart';
import 'package:almaraa_drivers/widget/shared/driver_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/auth.dart';
import 'package:almaraa_drivers/provider/driver_location.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/utilities/behavior.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/home/order_card.dart';
import 'package:almaraa_drivers/widget/home/number_of_orders.dart';
import 'package:almaraa_drivers/widget/shared/retry.dart';
import 'package:almaraa_drivers/widget/shared/spinkit_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    final _auth = Provider.of<Auth>(context, listen: false);
    final _orders = Provider.of<OrdersProvider>(context, listen: false);
    //get all orders
    _orders.getOrdersData(
        context: context, userId: _auth.user.data.integrateId.toString());
  }

  final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context);
    final _driverLocation =
        Provider.of<DriverLocationProvider>(context, listen: true);
    final _auth = Provider.of<Auth>(context, listen: false);
    _driverLocation.driverId = _auth.user.data.id;
    SizeConfig().init(context);
    return DriverDrawer(
      controller: _orders.advancedDrawerController,
      child: Scaffold(
        key: _homeKey,
        extendBody: true,
        //drawer: TurkiDrawer(),
        appBar: DriverAppBar(
          user: _auth.user,
        ),
        body: Background(
          child: _orders.isLoading
              ? SpinkitIndicator()
              : _orders.retry
                  ? Retry(
                      onPressed: () {
                        _orders.reInitOrdersData(
                            userId: _auth.user.data.integrateId.toString());
                      },
                    )
                  : ScrollConfiguration(
                      behavior: Behavior(),
                      child: RefreshIndicator(
                        color: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).backgroundColor,
                        onRefresh: () async {
                          await _orders.getOrdersData(
                              context: context,
                              userId: _auth.user.data.integrateId.toString());
                        },
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: SizeConfig.screenHeight!),
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            children: [
                              LocationCard(
                                location: _driverLocation.currentLocation,
                              ),
                              NumberOfOrders(
                                  orders: _orders.ordersData!.data!.length,
                                  remainingOrders: _orders.remainingOrders),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _orders.ordersData!.data!.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: OrderCard(
                                        index: index,
                                        order: _orders.ordersData!.data![index],
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
