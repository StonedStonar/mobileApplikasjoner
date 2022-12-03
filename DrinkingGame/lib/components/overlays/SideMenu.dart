import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/MenuButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {

  ///Makes an insance of the side menu.
  ///[child] the content of the menu.
  ///[title] the title of the side menu
  SideMenu({required this.child, this.title, Key? key}) : super(key: key);

  final String? title;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Scaffold(
          appBar: makeMenuAppBar(context, title),
          body: child,
        ),
    );
  }


}
