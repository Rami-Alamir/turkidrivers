import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/widget/timeline/dot_indicator.dart';
import 'solid_line_connector.dart';

class TimeLine13 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DotIndicator(
                borderColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
              ),
              Text(
                  AppLocalizations.of(context)!
                      .tr('theـorderـwasـreceivedـslaughterhouse'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 16, color: Colors.black))
            ],
          ),
          SolidLineConnector(color: Theme.of(context).primaryColor),
          Row(
            children: [
              DotIndicator(
                borderColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
              ),
              Text(AppLocalizations.of(context)!.tr('on_way'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 16, color: Colors.black))
            ],
          ),
          SolidLineConnector(color: Theme.of(context).primaryColor),
          Row(
            children: [
              DotIndicator(
                borderColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
              ),
              Text(AppLocalizations.of(context)!.tr('notـanswered'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 16, color: Colors.black))
            ],
          ),
          SolidLineConnector(color: Theme.of(context).primaryColor),
          Row(
            children: [
              DotIndicator(
                borderColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
              ),
              Text(
                  AppLocalizations.of(context)!
                      .tr('problem_being_solved_and_delivered'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 16, color: Colors.black))
            ],
          ),
        ],
      ),
    );
  }
}
