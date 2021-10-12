import 'package:almaraa_drivers/widget/shared/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/auth.dart';
import 'package:almaraa_drivers/provider/driver_location.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/behavior.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/home/order_card.dart';
import 'package:almaraa_drivers/widget/home/number_of_orders.dart';
import 'package:almaraa_drivers/widget/shared/retry.dart';
import 'package:almaraa_drivers/widget/shared/spinkit_indicator.dart';
import 'package:almaraa_drivers/widget/shared/turki_app_bar.dart';
import 'package:almaraa_drivers/widget/shared/turki_drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addObserver(this);
    // _checkPermission(_permission).then((_) => _checkingPermission = false);
    final _auth = Provider.of<Auth>(context, listen: false);
    final _orders = Provider.of<OrdersProvider>(context, listen: false);
    //get all orders
    _orders.getOrdersData(
        context: context, userId: _auth.user.data.integrateId.toString());
  }

  final Permission _permission = Permission.location;
  // bool _checkingPermission = false;

  final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();

  Future<void> _checkPermission(Permission permission) async {
    try {
      final status = await permission.request();
      print(status.toString());
      if (status == PermissionStatus.granted) {
        print('Permission granted');
      } else if (status == PermissionStatus.denied) {
        print(
            'Permission denied. Show a dialog and again ask for the permission');
        print('Take the user to the settings page.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    PermissionStatus _status;

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
                      onRefresh: () async {
                        await _orders.getOrdersData(
                            context: context,
                            userId: _auth.user.data.integrateId.toString());
                      },
                      child: Container(
                        constraints:
                            BoxConstraints(minHeight: SizeConfig.screenHeight!),
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
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
                                    foregroundColor: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.color,
                                  ),
                                ),
                              ],
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
                                        distance: 0.0),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
