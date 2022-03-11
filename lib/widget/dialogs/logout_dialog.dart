import 'package:almaraa_drivers/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';

class LogOutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        AppLocalizations.of(context)!.tr('Do_you_really_want_to_Log_out'),
        style: Theme.of(context).textTheme.headline4,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.tr('cancel'),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.tr('yes'),
          ),
          onPressed: () {
            final _orders = Provider.of<OrdersProvider>(context, listen: false);
            final _auth = Provider.of<Auth>(context, listen: false);
            _orders.clear();
            Navigator.pop(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/Login", (Route<dynamic> route) => false);
            _auth.logout();
            _orders.advancedDrawerController.hideDrawer();
          },
        )
      ],
    );
  }
}
