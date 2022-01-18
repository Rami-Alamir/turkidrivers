import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  final onPressed;
  const Retry({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.refresh,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
