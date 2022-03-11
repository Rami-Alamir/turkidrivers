import 'package:flutter/material.dart';

class AppBarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  AppBarWithTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Theme.of(context).splashColor,
        title: Text(title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 20, color: Theme.of(context).iconTheme.color)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
