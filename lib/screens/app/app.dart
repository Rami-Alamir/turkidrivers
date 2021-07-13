import 'package:almaraa_drivers/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/app_language.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:almaraa_drivers/utilities/route_generator.dart';

//App Widget tree
class MyApp extends StatefulWidget {
  final locale;
  final bool isAuth;
  const MyApp({required this.locale, required this.isAuth});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final language = Provider.of<AppLanguage>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    language.appLocale = widget.locale;
    if (widget.isAuth) auth.initUser();
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
    return Consumer<AppLanguage>(builder: (ctx, lang, child) {
      return MaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
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
