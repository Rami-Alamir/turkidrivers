import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';

class ConfirmDialog extends StatelessWidget {
  final String msg;
  final String route;

  const ConfirmDialog({
    required this.msg,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(AppLocalizations.of(context)!.tr(msg)),
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
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pushNamed(route);
          },
        )
      ],
    );
  }
}
