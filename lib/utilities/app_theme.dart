import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData(
      splashColor: Colors.white,
      primaryColor: Color.fromRGBO(132, 15, 15, 1),
      accentColor: Color.fromRGBO(236, 208, 117, 1),
      fontFamily: 'Tajawal',
      canvasColor: Colors.white,
      backgroundColor: Color.fromRGBO(252, 252, 252, 1),
      scaffoldBackgroundColor: Color.fromRGBO(252, 252, 252, 1),
      textTheme: TextTheme(
        subtitle1: TextStyle(fontSize: 28, color: Colors.white),
        headline1: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            height: 1.40,
            fontSize: 24),
        headline2: TextStyle(
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(87, 87, 87, 1),
            height: 1.40,
            fontSize: 18),
        headline3: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
        headline4: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        headline5: TextStyle(
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(87, 87, 87, 1),
            fontSize: 12),
        headline6: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      dialogTheme: DialogTheme(
        contentTextStyle: TextStyle(
            color: Color.fromRGBO(87, 87, 87, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16),
      ),
      dividerTheme: DividerThemeData(
        indent: 50,
        color: Colors.grey,
        thickness: .35,
        endIndent: 5,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: Color.fromRGBO(132, 15, 15, 1)),
      ),
      snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(
        fontFamily: 'Tajawal',
        color: Colors.white,
      )));
}
