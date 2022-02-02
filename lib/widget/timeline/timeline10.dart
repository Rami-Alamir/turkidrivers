import 'package:almaraa_drivers/utilities/ra7_icons.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/timeline/solid_line_connector.dart';
import 'package:almaraa_drivers/widget/timeline/timeline_row.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/widget/timeline/dot_indicator.dart';
import 'dashed_lin_connector.dart';

class TimeLine10 extends StatelessWidget {
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
            ],
          ),
          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeLineRow(
                  title: 'theـorderـwasـreceivedـslaughterhouse',
                  icon: RA7ICONS.truck_time,
                ),
                TimeLineRow(
                  title: 'on_way',
                  icon: RA7ICONS.delivering,
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

    // return Padding(
    //   padding: const EdgeInsets.all(25),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         children: [
    //           DotIndicator(
    //             borderColor: Theme.of(context).primaryColor,
    //             fillColor: Theme.of(context).primaryColor,
    //           ),
    //           Container(
    //             width: SizeConfig.screenWidth! * 0.7,
    //             child: Text(
    //                 AppLocalizations.of(context)!
    //                     .tr('theـorderـwasـreceivedـslaughterhouse'),
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline3!
    //                     .copyWith(fontSize: 16)),
    //           )
    //         ],
    //       ),
    //       DashedLineConnector(color: Colors.grey),
    //       Row(
    //         children: [
    //           DotIndicator(
    //             borderColor: Colors.grey,
    //             fillColor: Colors.transparent,
    //           ),
    //           Text(AppLocalizations.of(context)!.tr('on_way'),
    //               style: Theme.of(context)
    //                   .textTheme
    //                   .headline3!
    //                   .copyWith(fontSize: 16, color: Colors.grey))
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
