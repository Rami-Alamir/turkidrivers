import 'package:almaraa_drivers/provider/app_theme.dart';
import 'package:almaraa_drivers/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/app_language.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:almaraa_drivers/utilities/route_generator.dart';

//App Widget tree
class MyApp extends StatefulWidget {
  final Locale? locale;
  final bool isAuth;
  final theme;
  const MyApp(
      {required this.locale, required this.isAuth, required this.theme});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final language = Provider.of<AppLanguage>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    language.appLocale = widget.locale!;
    if (widget.isAuth) auth.initUser();

    final appTheme = Provider.of<AppTheme>(context, listen: false);
    appTheme.setThemeData = widget.theme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    // make app portrait mode only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //Consumer for change app language only
    final appTheme = Provider.of<AppTheme>(context);

    return Consumer<AppLanguage>(builder: (ctx, lang, child) {
      return MaterialApp(
        theme: appTheme.getThemeData,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => Stack(
          children: [child!, DropdownAlert()],
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: lang.appLocal,
        supportedLocales: [
          Locale('ar', ''),
          Locale('en', ''),
        ],
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: widget.isAuth ? '/Home' : '/Login',
      );
    });
  }
}
