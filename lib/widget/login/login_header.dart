import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100.0))),
                width: 200,
                height: 180),
          ],
        ),
        Positioned.fill(
          top: 0,
          left: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/car.png',
                fit: BoxFit.cover,
                width: 270,
                height: 1000,
              ),
            ],
          ),
        )
      ],
    );
  }
}
