import 'package:almaraa_drivers/widget/orders/note.dart';
import 'package:almaraa_drivers/widget/orders/status_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almaraa_drivers/provider/orders_provider.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusOption(
                  title: 'delivered',
                  selected: _orders.selected == 0,
                  onTap: (value) {
                    _orders.radioVal = 14;
                    _orders.setSelected = 0;
                  }),
              StatusOption(
                  title: 'problem_being_solved',
                  selected: _orders.selected == 1,
                  onTap: (value) {
                    _orders.radioVal = 12;
                    _orders.setSelected = 1;
                  }),
              StatusOption(
                  title: 'problem_being_solved_and_delivered',
                  selected: _orders.selected == 2,
                  onTap: (value) {
                    _orders.radioVal = 16;
                    _orders.setSelected = 2;
                  }),
              // Container(
              //     color: Colors.blue,
              //     child: groupListTile(context, 'delivered', 14)),
              // groupListTile(context, 'problem_being_solved', 12),
              // groupListTile(context, 'problem_being_solved_and_delivered', 16),
              Visibility(
                visible: _orders.radioValue == 12,
                child: Note(noteController: _orders.noteController),
              )
            ],
          ),
          RoundedRectangleButton(
              title: 'confirm',
              fontSize: 14,
              icon: Container(),
              height: 42,
              width: SizeConfig.screenWidth! * 0.64,
              padding: EdgeInsets.only(top: 15),
              onPressed: () {
                _orders.changeOrderStatus(
                    _orders.orderId.toString(), _orders.radioValue);
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  // Widget groupListTile(BuildContext context, String title, int groupValue) {
  //   final _order = Provider.of<OrdersProvider>(context, listen: false);
  //   return ListTile(
  //       onTap: () {
  //         _order.radioVal = groupValue;
  //       },
  //       title: Text(
  //         AppLocalizations.of(context)!.tr(title),
  //         style: Theme.of(context).textTheme.headline4,
  //       ),
  //       leading: Radio(
  //         value: _order.radioValue,
  //         groupValue: groupValue,
  //         onChanged: (value) {
  //           _order.radioVal = groupValue;
  //         },
  //         activeColor: Color.fromRGBO(132, 15, 15, 1),
  //       ));
  // }
}
