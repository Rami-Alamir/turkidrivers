import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:almaraa_drivers/provider/app_language.dart';
import 'package:almaraa_drivers/provider/auth.dart';
import 'package:almaraa_drivers/provider/driver_location.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/screens/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String? _languageCode = _preferences.getString('language_code');
  Locale _locale = Locale(_languageCode ?? 'ar');
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (context) => Auth()),
        ChangeNotifierProvider<DriverLocationProvider>(
            create: (context) => DriverLocationProvider()),
        ChangeNotifierProvider<AppLanguage>(create: (context) => AppLanguage()),
        ChangeNotifierProvider<OrdersProvider>(
            create: (context) => OrdersProvider()),
      ],
      child: MyApp(
        locale: _locale,
      )));
}
