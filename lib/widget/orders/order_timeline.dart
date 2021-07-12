import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/show_dialog.dart';
import 'package:almaraa_drivers/widget/shared/main_container.dart';
import 'package:almaraa_drivers/widget/timeline/timeline10.dart';
import 'package:almaraa_drivers/widget/timeline/timeline11.dart';
import 'package:almaraa_drivers/widget/timeline/timeline12.dart';
import 'package:almaraa_drivers/widget/timeline/timeline13.dart';
import 'package:almaraa_drivers/widget/timeline/timeline16.dart';
import 'package:almaraa_drivers/widget/timeline/timeline6.dart';

class OrderTimeline extends StatelessWidget {
  final int status;

  const OrderTimeline({required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0, top: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8, left: 8),
            child: Text(
              AppLocalizations.of(context)!.tr('order_status'),
              style:
                  Theme.of(context).textTheme.headline4?.copyWith(fontSize: 16),
            ),
          ),
          MainContainer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _timeline(status),
              Visibility(
                visible: (status != 6) && (status != 11) && (status != 13),
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, bottom: 8, left: 8),
                    child: TextButton(
                      onPressed: () {
                        ShowConfirmDialog().changeStatusDialog(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.tr('change_order_status'),
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _timeline(int status) {
    switch (status) {
      case 6:
        return TimeLine6();
      case 10:
        return TimeLine10();
      case 11:
        return TimeLine11();
      case 12:
        return TimeLine12();
      case 13:
        return TimeLine13();
      case 16:
        return TimeLine16();
      default:
        return TimeLine10();
    }
  }
}
