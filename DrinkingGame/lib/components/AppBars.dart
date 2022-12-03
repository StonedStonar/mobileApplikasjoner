import 'package:drinkinggame/components/GamePopUpMenu.dart';
import 'package:drinkinggame/pages/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/games/Game.dart';
import 'buttons/ElevatedIconButton.dart';

enum MenuItem { firstItem, secondItem }

///Makes the login app bar.
///Returns the appbar.
AppBar makeLoginAppBar() {
  return AppBar(
    title: makeAppbarText("Sign in"),
    toolbarHeight: 80,
    centerTitle: true,
  );
}

///Makes the normal app bar for the pages.
///[title] the title of the page.
///[context] the build context
///returns the wanted appbar.
AppBar makeNormalAppBar(String title, BuildContext context) {
  return AppBar(
    title: makeAppbarText(title),
    centerTitle: true,
    leading: makeMenuButton(),
    toolbarHeight: 80,
  );
}

///Makes the menu button.
///Returns the widget
Widget makeMenuButton(){
  return ElevatedIconButton(
    onPressed: (context) {
      Scaffold.of(context).openDrawer();
    },
    iconData: Icons.menu,
  );
}

///Makes the menus appbar.
///[context] the build context
///[title] the title of the appbar.
///Returns the appbar
AppBar makeMenuAppBar(BuildContext context, String? title) {
  return AppBar(
    title: makeAppbarText(title == null ? "Menu" : title),
    centerTitle: true,
    toolbarHeight: 80,
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
    leading: SizedBox(),
    toolbarHeight: 80,
    centerTitle: true,
  );
}

///Makes a basic appbar only containing a title
///Returns the basic app bar
AppBar makeBasicAppbar(String title) {
  return AppBar(
    title: makeAppbarText(title),
    centerTitle: true,
    toolbarHeight: 80,
  );
}

///Makes the heading for the appbar.
///[text] the text to make into a heading.
///Returns the appbar text
Text makeAppbarText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 26,
    ),
  );
}
