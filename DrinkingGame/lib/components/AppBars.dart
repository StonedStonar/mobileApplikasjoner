import 'package:drinkinggame/components/GamePopUpMenu.dart';
import 'package:drinkinggame/pages/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/games/Game.dart';
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
AppBar makeNormalAppBar(String title, BuildContext context) {
  return AppBar(
    title: makeAppbarText(title),
    centerTitle: true,
    leading: ElevatedIconButton(
      onPressed: (context) {
        Navigator.pop(context);
      },
      iconData: Icons.arrow_back,
    ),
    actions: [
      ElevatedIconButton(
        onPressed: (context) {
          Scaffold.of(context).openDrawer();
        },
        iconData: Icons.menu,
      )
    ],
    toolbarHeight: 80,
  );
}

///Makes the menus appbar.
///[context] the build context
///[title] the title of the appbar.
AppBar makeMenuAppBar(BuildContext context, String? title) {
  return AppBar(
    title: makeAppbarText(title == null ? "Menu" : title),
    centerTitle: true,
    leading: ElevatedIconButton(
      onPressed: (context) {
        Navigator.pop(context);
      },
      iconData: Icons.arrow_back,
    ),
    toolbarHeight: 80,
    shadowColor: Colors.white,
  );
}

///Makes the app bar that is used in games.
///[context] the build context
///[game] the game.
///returns the wanted appbar.
AppBar makeGameAppBar(BuildContext context, Game game) {
  return AppBar(
    title: makeAppbarText(game.getGameName()),
    actions: [
      GamePopUpMenu(),
    ],
    toolbarHeight: 80,
    centerTitle: true,
  );
}

///Makes a basic appbar only containing a title
AppBar makeBasicAppbar(String title) {
  return AppBar(
    title: makeAppbarText(title),
    centerTitle: true,
    toolbarHeight: 80,
  );
}

///Makes the heading for the appbar.
///[text] the text to make into a heading.
Text makeAppbarText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 26,
    ),
  );
}
