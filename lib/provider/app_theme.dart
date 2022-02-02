import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme with ChangeNotifier {
  late bool isLightTheme;
  SharedPreferences? _prefs;
  final String key = "theme";

  ThemeData get getThemeData => isLightTheme ? lightTheme : darkTheme;

  set setThemeData(bool val) {
    isLightTheme = val;
  }

  // init Shared Preferences
  Future<void> _initPrefs() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  // change then update user theme to local db
  changeTheme() {
    isLightTheme = !isLightTheme;
    _saveToPrefs();
    notifyListeners();
  }

  // save user theme to local db
  _saveToPrefs() async {
    await _initPrefs();
    _prefs?.setBool(key, isLightTheme);
  }
}

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color.fromRGBO(25, 25, 25, 1),
    splashColor: Color.fromRGBO(25, 25, 25, 1),
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    fontFamily: 'Tajawal',
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 20, color: Colors.white),
      subtitle2: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
      headline1: TextStyle(
          color: Colors.white,
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
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
      headline5: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(87, 87, 87, 1),
          fontSize: 12),
      headline6: TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontSize: 12,
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
      style: TextButton.styleFrom(
        primary: Color.fromRGBO(90, 4, 9, 1),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: 'Tajawal',
      color: Colors.white,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primaryVariant: Color.fromRGBO(28, 28, 28, 1),
        secondary: Color.fromRGBO(25, 25, 25, 1),
        brightness: Brightness.dark));

final lightTheme = ThemeData(
    brightness: Brightness.light,
    splashColor: Colors.white,
    iconTheme: IconThemeData(
      color: Color.fromRGBO(90, 4, 9, 1),
    ),
    primaryColor: Color.fromRGBO(90, 4, 9, 1),
    fontFamily: 'Tajawal',
    canvasColor: Colors.white,
    backgroundColor: Color.fromRGBO(252, 252, 252, 1),
    scaffoldBackgroundColor: Color.fromRGBO(252, 252, 252, 1),
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 20, color: Colors.white),
      subtitle2: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
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
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),
      headline4: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
      headline5: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(90, 4, 9, 1),
          fontSize: 12),
      headline6: TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontSize: 12,
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
      style: TextButton.styleFrom(
        primary: Color.fromRGBO(90, 4, 9, 1),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: 'Tajawal',
      color: Colors.white,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primaryVariant: Color.fromRGBO(240, 240, 240, 1),
        secondary: Colors.white,
        brightness: Brightness.light));
