import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {

  final List<PopupMenuEntry> menuList;
  final Widget? menuIcon;

  const PopUpMenu({Key? key, required this.menuList, this.menuIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: ((context) => menuList),
      icon: menuIcon,
    );
  }
}
