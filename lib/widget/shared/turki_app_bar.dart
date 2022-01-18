import 'package:flutter/material.dart';

class TurkiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool back;

  TurkiAppBar({this.back = true});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color color = isDark ? Colors.white : Theme.of(context).primaryColor;
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          isDark ? 'assets/images/turki3.png' : 'assets/images/turki.png',
          height: 30,
        ),
        centerTitle: true,
        leading: back
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios, color: color),
                onPressed: () => Navigator.of(context).pop(),
              )
            : Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: color),
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
