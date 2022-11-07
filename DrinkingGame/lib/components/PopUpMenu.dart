import 'package:flutter/material.dart';
import '../pages/GameSelectionPage.dart';

enum MenuItem {firstItem, secondItem}

class PopUpMenu extends StatelessWidget {

  PopUpMenu({required this.offset, required this.menuItems, Key? key}) : super(key: key);

  Offset offset;

  List<PopupMenuItem> menuItems;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text("Popup Menu"),
          actions: [
            PopupMenuButton<MenuItem>(
              onSelected: (value) {
                // First item you can click on
                print("Tap");
                if (value == MenuItem.firstItem) {
                  // Where to navigate to if clicked on
                  /*
                  Todo: Uncomment når vi skal navigere til neste side.
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GameSelectionPage(),
                  ));
                   */
                  // Second item you can click on
                } else if (value == MenuItem.secondItem) {
                  print("exit");
                  Navigator.pop(context);
                }
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

