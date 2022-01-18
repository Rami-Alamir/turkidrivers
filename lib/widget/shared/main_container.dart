import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';

class MainContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Color? color;
  const MainContainer(
      {required this.child,
      this.padding = const EdgeInsets.all(0),
      this.width,
      this.color,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? SizeConfig.screenWidth,
        height: height,
        decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade100
                    : Colors.transparent,
                blurRadius: 15,
                spreadRadius: 0.5,
              )
            ]),
        padding: padding,
        child: ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(10)),
            child: Container(
                width: SizeConfig.screenWidth,
                color: Color.fromRGBO(255, 255, 255, 0.05),
                child: child)));
  }
}
