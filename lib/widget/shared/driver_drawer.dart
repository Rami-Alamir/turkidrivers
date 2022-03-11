import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_language.dart';
import '../../provider/app_theme.dart';
import '../../provider/auth.dart';
import '../../utilities/app_localizations.dart';
import '../../utilities/ra7_icons.dart';
import '../../utilities/show_dialog.dart';

class DriverDrawer extends StatelessWidget {
  final AdvancedDrawerController controller;
  final Widget child;
  const DriverDrawer({required this.controller, required this.child});
  @override
  Widget build(BuildContext context) {
    final _appLanguage = Provider.of<AppLanguage>(context);
    final _appTheme = Provider.of<AppTheme>(context);
    final _auth = Provider.of<Auth>(context, listen: false);
    return AdvancedDrawer(
      backdropColor: Theme.of(context).primaryColor,
      controller: controller,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: AppLocalizations.of(context)!.locale!.languageCode == 'ar',
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/user.png"),
                            backgroundColor: Theme.of(context).backgroundColor,
                            radius: 25,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${_auth.user.data.name}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                Text(
                                  '${_auth.user.data.email}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.home,
                  onTap: () => controller.hideDrawer(),
                  text: 'home',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.phone,
                  onTap: () {
                    _makePhoneCall();
                  },
                  text: 'support',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.global,
                  onTap: () {
                    _appLanguage.changeLanguage();
                  },
                  text: 'language',
                ),
                _createDrawerItem(
                  context: context,
                  icon: !_appTheme.isLightTheme
                      ? Icons.brightness_4_outlined
                      : Icons.nightlight_outlined,
                  onTap: () {
                    _appTheme.changeTheme();
                  },
                  text: !_appTheme.isLightTheme ? 'light_mode' : 'night_mode',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.exit,
                  onTap: () {
                    ShowConfirmDialog().logoutDialog(context);
                  },
                  text: 'sign_out',
                ),
                Spacer(),
                Image.asset(
                  'assets/images/car.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 220,
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('V2.1.0'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: child,
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required BuildContext context,
      required String text,
      required GestureTapCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(AppLocalizations.of(context)!.tr(text),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white)),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Future<void> _makePhoneCall() async {
    if (await canLaunch('tel:+966118280980')) {
      await launch('tel:+966118280980');
    } else {
      throw 'Could not launch tel:+966118280980';
    }
  }
}
