import 'package:almaraa_drivers/provider/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/app_language.dart';
import 'package:almaraa_drivers/provider/auth.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/ra7_icons.dart';
import 'package:almaraa_drivers/utilities/show_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class TurkiDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appLanguage = Provider.of<AppLanguage>(context);
    final _appTheme = Provider.of<AppTheme>(context);
    final _auth = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(_auth.user.data.name),
                  accountEmail: Text(_auth.user.data.email),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    child: Text(
                      _auth.user.data.name.substring(0, 1).toUpperCase(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.home,
                  onTap: () => Navigator.of(context).pop(),
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
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Text('V2.0.0'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required BuildContext context,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(AppLocalizations.of(context)!.tr(text),
                style: Theme.of(context).textTheme.headline4),
          )
        ],
      ),
      onTap: onTap,
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