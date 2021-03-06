import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/shared/main_container.dart';

class NumberOfOrders extends StatelessWidget {
  final int orders;
  final int remainingOrders;

  const NumberOfOrders({required this.orders, required this.remainingOrders});

  Widget data(BuildContext context, String title, int value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, top: 20),
      child: MainContainer(
          width: SizeConfig.screenWidth! / 2 - 15,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.tr(title),
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(height: 2, fontSize: 16),
              ),
              Text(
                value.toString(),
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 18,
                    height: 2.4,
                    color: Color.fromRGBO(132, 15, 15, 1),
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        data(context, 'no_orders', orders),
        data(context, 'remaining_orders', remainingOrders),
      ],
    );
  }
}
