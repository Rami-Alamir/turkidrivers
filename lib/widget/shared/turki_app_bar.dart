import 'package:flutter/material.dart';

class TurkiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool back;

  TurkiAppBar({this.back = true});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/images/turki.png',
          height: 30,
        ),
        centerTitle: true,
        leading: back
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor),
                onPressed: () => Navigator.of(context).pop(),
              )
            : Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
