import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusOption extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onTap;

  const StatusOption(
      {required this.title, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: selected,
                fillColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                checkColor: Colors.white, // color of tick Mark
                activeColor: Theme.of(context).textTheme.headline1!.color!,
                onChanged: (bool? value) {
                  onTap(value);
                },
              ), //Checkbox
              Container(
                width: SizeConfig.screenWidth! * .53,
                child: Text(
                  AppLocalizations.of(context)!.tr(title),
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: 13.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
