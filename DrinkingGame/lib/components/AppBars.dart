import 'package:flutter/material.dart';

import '../pages/GamePage.dart';
import 'buttons/ElevatedIconButton.dart';

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

///Makes the normal app bar for the pages.
///[title] the title of the page.
///[context] the build context
///returns the wanted appbar.
AppBar makeNormalAppBar(String title, BuildContext context){
  return AppBar(
    title: makeAppbarText(title),
    centerTitle: true,
    leading: ElevatedIconButton(
      onPressed: (context) {Scaffold.of(context).openDrawer();},
      iconData: Icons.menu,
    )
  );
}

AppBar makeMenuAppBar(BuildContext context){
  return AppBar(
    title: makeAppbarText("Menu"),
    centerTitle: true,
    leading: ElevatedIconButton(
      onPressed: (context) {Navigator.pop(context);},
      iconData: Icons.arrow_back,
    ),
  );
}

//Todo: Denne må implementeres.
///Makes the app bar that is used in games.
///[context] the build context
///returns the wanted appbar.
AppBar makeGameAppBar(BuildContext context){
  return AppBar(
    actions: [
      PopupMenuButton<MenuItem>(
        onSelected: (value) {
          // First item you can click on
          if (value == MenuItem.firstItem) {
            // Where to navigate to if clicked on
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GamePage(),
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
    title: makeAppbarText("Drinking games"),
    toolbarHeight: 80,
    centerTitle: true,
  );
}

Text makeAppbarText(String text){
  return Text(
    text,
    style: TextStyle(
      fontSize: 24,
    ),
  );
}