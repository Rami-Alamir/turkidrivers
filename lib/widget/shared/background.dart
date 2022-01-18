import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  Background({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.9, 1],
          colors: Theme.of(context).brightness == Brightness.light
              ? [
                  Colors.white10,
                  Colors.white10,
                ]
              : [
                  Colors.black,
                  Color.fromRGBO(30, 30, 33, 1),
                ],
        ),
      ),
      child: child,
    );
  }
}
