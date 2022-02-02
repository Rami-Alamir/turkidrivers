import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String? title;
  final Function onPressed;
  final double fontSize;
  final double width;
  final Widget icon;
  final double height;
  final EdgeInsets padding;
  final FocusNode? focusNode;

  const RoundedRectangleButton(
      {required this.title,
      required this.onPressed,
      required this.icon,
      this.fontSize = 20,
      this.width = 300,
      this.padding = const EdgeInsets.all(25.0),
      this.height = 55,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            constraints: BoxConstraints.tight(Size(width, height)),
            onPressed: () {
              onPressed();
            },
            elevation: 0.0,
            splashColor: Colors.transparent,
            focusElevation: 0,
            focusNode: focusNode,
            highlightColor: Colors.transparent,
            fillColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(const Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${AppLocalizations.of(context)!.tr(title!)}'
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: fontSize, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
