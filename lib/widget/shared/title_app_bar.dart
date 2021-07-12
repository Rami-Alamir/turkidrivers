import 'package:flutter/material.dart';

class AppBarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  AppBarWithTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Theme.of(context).primaryColor, fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
