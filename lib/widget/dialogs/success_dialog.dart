import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          width: 200.0,
          height: 250.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color.fromRGBO(40, 40, 40, 1),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.done, color: Colors.white, size: 70),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  AppLocalizations.of(context)!.tr('successfully_updated'),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          )),
    );
  }
}
