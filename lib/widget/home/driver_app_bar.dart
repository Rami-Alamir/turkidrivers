import 'package:almaraa_drivers/models/user.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/utilities/ra7_icons.dart';
import 'package:almaraa_drivers/widget/home/driver_qr.dart';
import 'package:almaraa_drivers/widget/home/qr_dialog.dart';
import 'package:flutter/material.dart';

class DriverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;

  DriverAppBar({required this.user});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(35.0),
                bottomLeft: Radius.circular(35.0)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        AppLocalizations.of(context)!.locale == Locale('ar')
                            ? RA7ICONS.menu_right
                            : RA7ICONS.menu_left,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    Image.asset(
                      'assets/images/turki3.png',
                      height: 30,
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png"),
                            backgroundColor: Theme.of(context).backgroundColor,
                            radius: 25,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.tr('hala')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontSize: 18),
                                ),
                                Text('${user.data.name}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return QrDialog(
                                  id: user.data.id.toString(),
                                );
                              });
                        },
                        child: DriverQr(
                          id: user.data.id.toString(),
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(160);
}
