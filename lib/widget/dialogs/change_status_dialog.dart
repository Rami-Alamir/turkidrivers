import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:almaraa_drivers/widget/shared/rounded_rectangle_button.dart';

class ChangeStatusDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      content: Container(
        width: SizeConfig.screenWidth! * 0.95,
        height: 350,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          width: SizeConfig.screenWidth! * 0.95,
          height: SizeConfig.screenHeight! * 0.7,
          child: Column(
            children: [
              groupListTile(context, 'delivered', 11),
              groupListTile(context, 'canceled', 6),
              groupListTile(context, 'problem_being_solved', 12),
              groupListTile(context, 'problem_being_solved_and_delivered', 13),
              RoundedRectangleButton(
                  title: 'confirm',
                  fontSize: 14,
                  height: 42,
                  width: SizeConfig.screenWidth! * 0.4,
                  padding: EdgeInsets.only(top: 40),
                  onPressed: () {
                    _orders.changeOrderStatus();
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget groupListTile(BuildContext context, String title, int groupValue) {
    final _order = Provider.of<OrdersProvider>(context, listen: false);
    return ListTile(
        title: Text(
          AppLocalizations.of(context)!.tr(title),
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: Radio(
          value: _order.radioValue,
          groupValue: groupValue,
          onChanged: (value) {
            _order.radioVal = groupValue;
          },
          activeColor: Theme.of(context).primaryColor,
        ));
  }
}
