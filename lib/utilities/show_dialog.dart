import 'package:flutter/material.dart';
import 'package:almaraa_drivers/widget/dialogs/change_status_dialog.dart';
import 'package:almaraa_drivers/widget/dialogs/confirm_dialog.dart';
import 'package:almaraa_drivers/widget/dialogs/logout_dialog.dart';

class ShowConfirmDialog {
  Future confirmDialog(BuildContext context, String msg, String route) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return ConfirmDialog(msg: msg, route: route);
      },
    );
  }

  Future logoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return LogOutDialog();
      },
    );
  }

  Future changeStatusDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ChangeStatusDialog();
      },
    );
  }
}
