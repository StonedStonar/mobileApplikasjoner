import 'package:flutter/material.dart';
import '../pages/GamePage.dart';

///Makes the login app bar.
///Returns the appbar.
AppBar makeLoginAppBar() {
  return AppBar(
    title: Text(
      "Sign in",
      style: TextStyle(
        fontSize: 30,
      ),
    ),
    toolbarHeight: 80,
    centerTitle: true,
  );
}

enum MenuItem { firstItem, secondItem }

AppBar gamePageAppBar(BuildContext context) {
  return AppBar(

    actions: [
      PopupMenuButton<MenuItem>(
        onSelected: (value) {
          // First item you can click on
          if (value == MenuItem.firstItem) {
            // Where to navigate to if clicked on
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const GamePage(),
            ));
            // Second item you can click on
          } else if (value == MenuItem.secondItem) {}
        },
        offset: Offset(0.0, 80.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        itemBuilder: (context) => const [
          // First Item in the popup menu
          PopupMenuItem(
            value: MenuItem.firstItem,
            child: Text('About game'),
          ),
          // Second Item in the popup menu
          PopupMenuItem(
            value: MenuItem.secondItem,
            child: Text('Exit game'),
          ),
        ],
      ),
    ],
    title: Text(
      "Drinking games",
      style: TextStyle(
        fontSize: 30,
      ),
    ),
    toolbarHeight: 80,
    centerTitle: true,
  );
}
