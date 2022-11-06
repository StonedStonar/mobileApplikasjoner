import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/GameButton.dart';
import 'package:drinkinggame/model/Game.dart';
import 'package:drinkinggame/model/InfoGame.dart';
import 'package:drinkinggame/pages/InfoGamePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/overlays/MainMenu.dart';

///TODO: Hører ikke hjemme her. Putt i egen fil.
enum MenuItem {firstItem, secondItem, thirdItem}

class GameSelectionPage extends ConsumerWidget {
  const GameSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: makeNormalAppBar("Games", context),
      body: _contentOfGamePage(context),
      drawer: MainMenu(),
    );
  }

  ///Makes the content of the game page.
  ///[context] the build context.
  ///Returns the widget
  Widget _contentOfGamePage(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16.0),
        GameButton(
          game: makeDefaultGame(),
          //TODO should re-direct the player to the game when pressed.
          onPressed: () => _openPage(InfoGamePage(game: makeDefaultGame()), context),
        ),
        /*
        const SizedBox(height: 16.0),
        GameButton(
          text: "Ring of Fire rules",
          subtext: "Only rules",
          //TODO should re-direct the player to the game when pressed.
          onPressed: () {},
        ),
        const SizedBox(height: 16.0),
        */
      ],
    );
  }

  ///Opens a new page.
  ///[widget] widget to open on a new page.
  ///[context] the build context.
  void _openPage(Widget widget, BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  Game makeDefaultGame(){
    List<String> peppa = [];
    peppa.add("Lol");
    return InfoGame(rules: peppa, gameName: "Ring of fire", shortDescription: "Information game");
  }
}
