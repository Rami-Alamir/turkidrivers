import 'package:almaraa_drivers/widget/timeline/timeline9.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/show_dialog.dart';
import 'package:almaraa_drivers/widget/shared/main_container.dart';
import 'package:almaraa_drivers/widget/timeline/timeline10.dart';
import 'package:almaraa_drivers/widget/timeline/timeline11.dart';
import 'package:almaraa_drivers/widget/timeline/timeline12.dart';
import 'package:almaraa_drivers/widget/timeline/timeline13.dart';
import 'package:almaraa_drivers/widget/timeline/timeline6.dart';

class OrderTimeline extends StatelessWidget {
  final int status;
  final String salesOrderId;
  const OrderTimeline({required this.status, required this.salesOrderId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0, top: 90),
      child: MainContainer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 15, 10),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.tr('order_id'),
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 14,
                      ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                  child: Text(
                    '$salesOrderId',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ),
              ],
            ),
          ),
          _timeline(status),
          Visibility(
            visible: (status != 6) && (status != 14) && (status != 16),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8, left: 8),
                child: TextButton(
                  onPressed: () {
                    ShowConfirmDialog().changeStatusDialog(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.tr('change_order_status'),
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _timeline(int status) {
    switch (status) {
      case 6:
        return TimeLine6();
      case 9:
        return TimeLine9();
      case 10:
        return TimeLine10();
      case 14:
        return TimeLine11();
      case 12:
        return TimeLine12();
      case 16:
        return TimeLine13();
      default:
        return TimeLine10();
    }
  }
}
