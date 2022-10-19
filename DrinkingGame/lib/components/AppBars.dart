import 'package:flutter/material.dart';
import '../pages/GamePage.dart';

///Makes the login app bar.
///Returns the appbar.

AppBar makeLoginAppBar() {
  return AppBar(
    title: const Text(
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
        offset: const Offset(0.0, 80.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        itemBuilder: (context) => [
          // First Item in the popup menu
          const PopupMenuItem(
            value: MenuItem.firstItem,
            child: Text('About game'),
          ),
          // Second Item in the popup menu
          const PopupMenuItem(
            value: MenuItem.secondItem,
            child: Text('Exit game'),
          ),
        ],
      ),
    ],
    title: const Text(
      "Drinking games",
      style: TextStyle(
        fontSize: 30,
      ),
    ),
    toolbarHeight: 80,
    centerTitle: true,
  );
}
