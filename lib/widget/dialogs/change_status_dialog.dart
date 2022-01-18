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
    _orders.noteController.clear();
    return AlertDialog(
      backgroundColor: Theme.of(context).splashColor,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              groupListTile(context, 'delivered', 14),
              groupListTile(context, 'problem_being_solved', 12),
              groupListTile(context, 'problem_being_solved_and_delivered', 16),
              Visibility(
                visible: _orders.radioValue == 12,
                child: TextField(
                    style: Theme.of(context).textTheme.headline4,
                    maxLines: 2,
                    controller: _orders.noteController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      hintText: 'سبب المشكلة',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    )),
              )
            ],
          ),
          RoundedRectangleButton(
              title: 'confirm',
              fontSize: 14,
              height: 42,
              width: SizeConfig.screenWidth! * 0.4,
              padding: EdgeInsets.only(top: 40),
              onPressed: () {
                _orders.changeOrderStatus(
                    _orders.orderId.toString(), _orders.radioValue);
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  Widget groupListTile(BuildContext context, String title, int groupValue) {
    final _order = Provider.of<OrdersProvider>(context, listen: false);
    return ListTile(
        onTap: () {
          _order.radioVal = groupValue;
        },
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
          activeColor: Color.fromRGBO(132, 15, 15, 1),
        ));
  }
}
