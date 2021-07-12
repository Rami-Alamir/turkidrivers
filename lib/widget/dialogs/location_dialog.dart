import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';

class LocationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(AppLocalizations.of(context)!.tr('background_location')),
      actions: <Widget>[
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.tr('ok'),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
