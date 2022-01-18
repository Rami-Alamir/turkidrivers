import 'package:almaraa_drivers/widget/shared/rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'driver_qr.dart';

class QrDialog extends StatelessWidget {
  final String id;

  const QrDialog({required this.id});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 350,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DriverQr(
                id: id,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                size: 180,
              ),
              RoundedRectangleButton(
                title: "done",
                width: 200,
                height: 50,
                padding: EdgeInsets.only(top: 20),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
