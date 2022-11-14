import 'package:flutter/material.dart';
import '../pages/GameSelectionPage.dart';

enum MenuItem {firstItem, secondItem}

class GamePopUpMenu extends StatelessWidget {

  const GamePopUpMenu({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: (value) {
        // First item you can click on
        switch(value){
          case MenuItem.firstItem:
            Scaffold.of(context).openDrawer();
            break;
          case MenuItem.secondItem:
            Navigator.pushNamed(context, "/landingPage");
            break;
        }
      },
      offset: const Offset(0.0, 80.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      itemBuilder: (context) => [
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
    );
  }
}

