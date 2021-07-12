import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';

class MainContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  const MainContainer(
      {required this.child,
      this.padding = const EdgeInsets.all(0),
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? SizeConfig.screenWidth,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 33,
                spreadRadius: 0.5,
              )
            ]),
        padding: padding,
        child: ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(10)),
            child: Container(
                width: SizeConfig.screenWidth,
                color: Colors.white,
                child: child)));
  }
}
