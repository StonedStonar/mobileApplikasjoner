
import 'package:drinkinggame/components/buttons/ElevatedIconButton.dart';
import 'package:drinkinggame/components/overlays/NormalMenu.dart';
import 'package:drinkinggame/components/overlays/SideMenu.dart';
import 'package:flutter/material.dart';

///Makes the login app bar.
///Returns the appbar.
AppBar makeLoginAppBar(){
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
AppBar makeNormalAppBar(String title, BuildContext context, Function(BuildContext) callback){
  return AppBar(
    title: makeAppbarText(title),
    centerTitle: true,
    leading: ElevatedIconButton(
      onPressed: callback,
      iconData: Icons.menu,
    )
  );
}

//Todo: Denne må implementeres.
///Makes the app bar that is used in games.
///returns the wanted appbar.
AppBar makeGameAppBar(){
  return AppBar();
}

Text makeAppbarText(String text){
  return Text(
    text,
    style: TextStyle(
      fontSize: 24,
    ),
  );
}