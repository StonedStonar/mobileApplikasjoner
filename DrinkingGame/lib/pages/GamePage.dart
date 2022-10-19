import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/GameButton.dart';
import 'package:flutter/material.dart';

import '../components/overlays/SideMenu.dart';

enum MenuItem {firstItem, secondItem, thirdItem}

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeNormalAppBar("Games", context),
      body: _contentOfGamePage(context),
      drawer: SideMenu(),
    );
  }

  Widget _contentOfGamePage(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16.0),
        GameButton(
          text: "Never have i ever",
          subtext: "Players 1-100",
          onPressed: () {},
        ),
        const SizedBox(height: 16.0),
        GameButton(
          text: "Ring of Fire rules",
          subtext: "Only rules",
          onPressed: () {},
        ),
        const SizedBox(height: 16.0),
        GameButton(
          text: "Truth or dare",
          subtext: "Players 1-10",
          onPressed: () {},
        ),
      ],
    );
  }
}
