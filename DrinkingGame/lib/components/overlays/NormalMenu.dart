import 'package:drinkinggame/components/overlays/SideMenu.dart';
import 'package:flutter/cupertino.dart';

class NormalMenu extends StatelessWidget {

  NormalMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideMenu(child: Text("HEi"));
  }
}
