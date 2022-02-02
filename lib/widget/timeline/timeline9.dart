import 'package:almaraa_drivers/utilities/ra7_icons.dart';
import 'package:almaraa_drivers/widget/timeline/timeline_row.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/widget/timeline/dot_indicator.dart';
import 'dashed_lin_connector.dart';

class TimeLine9 extends StatelessWidget {
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
              DashedLineConnector(
                color: Colors.grey,
              ),
              DotIndicator(
                borderColor: Colors.grey,
                fillColor: Colors.grey,
                shadowRadius: 3,
              ),
            ],
          ),
          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeLineRow(
                  title: 'prepared',
                  icon: RA7ICONS.oreder_done,
                ),
                TimeLineRow(
                  title: 'theـorderـwasـreceivedـslaughterhouse',
                  icon: RA7ICONS.truck_time,
                  divider: false,
                ),
              ],
            ),
          ),
        ],
      ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     TimeLineRow(
      //       title: 'theـorderـwasـreceivedـslaughterhouse',
      //       icon: RA7ICONS.oreder_done,
      //       shadowRadius: 3,
      //     ),
      //     SolidLineConnector(
      //       color: Colors.green,
      //     ),
      //     TimeLineRow(
      //       title: 'on_way',
      //       icon: RA7ICONS.delivering,
      //       shadowRadius: 3,
      //     ),
      //     SolidLineConnector(color: Colors.green),
      //     TimeLineRow(
      //       title: 'delivered',
      //       icon: RA7ICONS.delivered,
      //       shadowRadius: 3,
      //     ),
      //   ],
      // ),
    );
  }
}
