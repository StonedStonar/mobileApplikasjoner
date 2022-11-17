import 'package:drinkinggame/pages/gamePages/truthordare/TruthOrDarePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../App.dart';
import '../../model/games/Game.dart';
import '../../model/games/InfoGame.dart';
import '../../model/games/StatementGame.dart';
import 'InfoGamePage.dart';

///The page that is used to switch the game from one page to the other. It finds out what kind of game it is and redirects it.
class GameLandingPage extends ConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<Game?>(
        stream: ref.watch(gameProvider.notifier).stream,
        builder: (context, game) {
          Widget widget = new CircularProgressIndicator();
          print("Størrelse: ${game.data?.getGameRegister().getRegisterItems().length}");
          switch(game.data.runtimeType){
            case InfoGame:
              widget = InfoGamePage(infoGame: game.data as InfoGame);
              break;
            case StatementGame:
              widget = TruthOrDarePage();
              break;
          }
          return widget;
        }
    );
  }

}