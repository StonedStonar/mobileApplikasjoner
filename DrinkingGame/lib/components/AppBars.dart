import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/GamePage.dart';
import 'buttons/ElevatedIconButton.dart';

///Makes the login app bar.
///Returns the appbar.
AppBar makeLoginAppBar() {
  return AppBar(
    title: makeAppbarText("Sign in"),
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
    ),
    toolbarHeight: 80,
  );
}


///Makes the menus appbar.
///[context] the build context
///[title] the title of the appbar.
AppBar makeMenuAppBar(BuildContext context, String? title){
  return AppBar(
    title: makeAppbarText(title == null ? "Menu" : title),
    centerTitle: true,
    leading: ElevatedIconButton(
      onPressed: (context) {Navigator.pop(context);},
      iconData: Icons.arrow_back,
    ),
    toolbarHeight: 80,
    shadowColor: Colors.white,
  );
}

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

///Makes the heading for the appbar.
///[text] the text to make into a heading.
Text makeAppbarText(String text){
  return Text(
    text,
    style: TextStyle(
      fontSize: 26,
    ),
  );
}