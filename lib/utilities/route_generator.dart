import 'package:flutter/material.dart';
import 'package:almaraa_drivers/screens/home/home.dart';
import 'package:almaraa_drivers/screens/login/login.dart';
import 'package:almaraa_drivers/screens/orders/order_details.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
      case '/Home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/OrderDetails':
        return MaterialPageRoute(builder: (_) => OrderDetails(orderId: args));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
