import 'package:flutter/material.dart';
import 'package:almaraa_drivers/widget/dialogs/success_dialog.dart';

class ShowSuccessDialog {
  Future successDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return SuccessDialog();
        });
  }
}
