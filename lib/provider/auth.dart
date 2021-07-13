import 'package:almaraa_drivers/widget/dialogs/location_dialog.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/models/user.dart';
import 'package:almaraa_drivers/repository/registration_repository.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/widget/shared/indicator_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  late User _user;
  SharedPreferences? _prefs;

  User get user => _user;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //for test

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  BuildContext? context;

  BuildContext? _dialogContext;
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  void initUser() async {
    await _initPrefs();
    _user = User(
        success: true,
        data: Data(
            id: _prefs!.getInt('id')!,
            email: _prefs!.getString('email')!,
            name: _prefs!.getString('name')!));
  }

  void login(BuildContext context) {
    this.context = context;
    if (!_loginFormKey.currentState!.validate())
      _login();
    else
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        AppLocalizations.of(context)!
            .tr('please_enter_all_required_information'),
        textAlign: TextAlign.center,
      )));
  }

  Future<void>? _login() async {
    _showDialogIndicator(context!);
    try {
      _user = await RegistrationRepository().login({
        "email": userNameController.text.trim(),
        "password": passwordController.text.trim()
      });
      await _initPrefs();
      _prefs!.setInt('id', user.data.id);
      _prefs!.setString('name', user.data.name);
      _prefs!.setString('email', user.data.email);
      _prefs!.setBool('isAuth', true);
      Navigator.of(_dialogContext!).pop();
      passwordController.clear();
      Navigator.of(context!)
          .pushNamedAndRemoveUntil("/Home", (Route<dynamic> route) => false);
    } catch (e) {
      Navigator.of(_dialogContext!).pop();
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text(
        AppLocalizations.of(context!)!.tr('Incorrect_email_password'),
        textAlign: TextAlign.center,
      )));
      print('error:   ${e.toString()}');
    }
  }

  void _showDialogIndicator(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return IndicatorDialog();
        });
  }

  void showLocationDialog(BuildContext context) async {
    await _initPrefs();
    bool? _isFirstUse = _prefs?.getBool('isFirstUse');
    if (_isFirstUse ?? true) {
      _prefs?.setBool('isFirstUse', false);
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            _dialogContext = context;
            return LocationDialog();
          });
    }
  }

  void logout() async {
    await _initPrefs();
    _prefs!.remove('id');
    _prefs!.remove('name');
    _prefs!.remove('email');
    _prefs!.remove('isAuth');
  }

  // init Shared Preferences
  Future<void> _initPrefs() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }
}
