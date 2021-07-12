import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/auth.dart';
import 'package:almaraa_drivers/provider/driver_location.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/behavior.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/home/number_of_orders.dart';
import 'package:almaraa_drivers/widget/home/order_card.dart';
import 'package:almaraa_drivers/widget/shared/retry.dart';
import 'package:almaraa_drivers/widget/shared/spinkit_indicator.dart';
import 'package:almaraa_drivers/widget/shared/turki_app_bar.dart';
import 'package:almaraa_drivers/widget/shared/turki_drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
    _orders.getOrdersData(
        context: context, userId: _auth.user.data.id.toString());
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
    return Scaffold(
      key: _homeKey,
      extendBody: true,
      drawer: TurkiDrawer(),
      appBar: TurkiAppBar(
        back: false,
      ),
      body: _orders.isLoading
          ? SpinkitIndicator()
          : _orders.retry
              ? Retry(
                  onPressed: () {
                    _orders.reInitOrdersData(
                        userId: _auth.user.data.id.toString());
                  },
                )
              : ScrollConfiguration(
                  behavior: Behavior(),
                  child: RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    onRefresh: () async {
                      await _orders.getOrdersData(
                          context: context,
                          userId: _auth.user.data.id.toString());
                    },
                    child: Container(
                      constraints:
                          BoxConstraints(minHeight: SizeConfig.screenHeight!),
                      child: ListView(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              '${AppLocalizations.of(context)!.tr('hala')} ${_auth.user.data.name}',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: QrImage(
                                  data: _auth.user.data.id.toString(),
                                  version: QrVersions.auto,
                                  size: 150.0,
                                ),
                              ),
                            ],
                          ),
                          NumberOfOrders(
                              orders: _orders.ordersData!.orderCount!,
                              remainingOrders:
                                  _orders.ordersData!.remainingOrders!),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _orders.ordersData!.order!.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                try {
                                  _orders.ordersData!.order![index]
                                          .deliveryAddress!.distance =
                                      _driverLocation.calculateDistance(
                                          _orders.ordersData?.order?[index]
                                                  .deliveryAddress?.latitude ??
                                              0,
                                          _orders.ordersData?.order?[index]
                                                  .deliveryAddress?.longitude ??
                                              0);
                                  if (index ==
                                      _orders.ordersData!.order!.length - 1)
                                    _orders.sortOrdersList();
                                } catch (e) {
                                  print("error :${e.toString()}");
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: OrderCard(
                                      index: index,
                                      order: _orders.ordersData!.order![index],
                                      distance: _orders
                                                  .ordersData
                                                  ?.order?[index]
                                                  .deliveryAddress ==
                                              null
                                          ? 0.00
                                          : (_orders.ordersData?.order?[index]
                                              .deliveryAddress?.distance!)),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
