import 'package:almaraa_drivers/utilities/ra7_icons.dart';
import 'package:almaraa_drivers/widget/timeline/timeline_row.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/widget/timeline/dot_indicator.dart';
import 'solid_line_connector.dart';

class TimeLine13 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DotIndicator(
                borderColor: Colors.green,
                fillColor: Colors.green,
                shadowRadius: 3,
              ),
              SolidLineConnector(
                color: Colors.green,
              ),
              DotIndicator(
                borderColor: Colors.green,
                fillColor: Colors.green,
                shadowRadius: 3,
              ),
              SolidLineConnector(color: Colors.green),
              DotIndicator(
                borderColor: Colors.green,
                fillColor: Colors.green,
                shadowRadius: 3,
              ),
              SolidLineConnector(
                color: Colors.grey,
              ),
              DotIndicator(
                borderColor: Colors.green,
                fillColor: Colors.green,
                shadowRadius: 3,
              ),
            ],
          ),
          Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeLineRow(
                  title: 'theـorderـwasـreceivedـslaughterhouse',
                  icon: RA7ICONS.oreder_done,
                ),
                TimeLineRow(
                  title: 'on_way',
                  icon: RA7ICONS.delivering,
                ),
                TimeLineRow(
                  title: 'notـanswered',
                  icon: RA7ICONS.call_calling,
                ),
                TimeLineRow(
                  title: 'problem_being_solved_and_delivered',
                  icon: RA7ICONS.delivered,
                  divider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
