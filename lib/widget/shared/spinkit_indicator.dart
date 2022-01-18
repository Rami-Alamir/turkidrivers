import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinkitIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: SpinKitPulse(
          color: Color.fromRGBO(132, 15, 15, 1),
          size: 30.0,
        ),
      ),
    );
  }
}
