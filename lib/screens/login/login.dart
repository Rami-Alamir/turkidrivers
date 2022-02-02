import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/auth.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/login/login_header.dart';
import 'package:almaraa_drivers/widget/login/rectangle_text_field.dart';
import 'package:almaraa_drivers/widget/shared/rounded_rectangle_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _auth = Provider.of<Auth>(context);
    //  _auth.showLocationDialog(context);
    return Scaffold(
      extendBody: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Form(
            key: _auth.loginFormKey,
            child: Column(
              children: [
                LoginHeader(),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.screenHeight! / 20, bottom: 50.0),
                  child: Image.asset(
                    'assets/images/turki.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                RectangleTextField(
                  controller: _auth.userNameController,
                  hint: AppLocalizations.of(context)?.tr('username'),
                  focusNode: _focusNode1,
                  nextFocusNode: _focusNode2,
                ),
                RectangleTextField(
                  controller: _auth.passwordController,
                  hint: AppLocalizations.of(context)?.tr('password'),
                  focusNode: _focusNode2,
                  nextFocusNode: _focusNode3,
                  obscureText: true,
                  padding: EdgeInsets.all(25),
                ),
                RoundedRectangleButton(
                  icon: Container(),
                  onPressed: () {
                    _auth.login(context);
                  },
                  focusNode: _focusNode3,
                  title: 'login',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
