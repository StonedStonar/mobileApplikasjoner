import 'package:flutter/material.dart';
import '../pages/GamePage.dart';

enum MenuItem {firstItem, secondItem}

class PopUpMenu extends StatelessWidget {

  const PopUpMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text("Popup Menu"),
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
              itemBuilder: (context) =>
              const [
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
        ),
      );
}
