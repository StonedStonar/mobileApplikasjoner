import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/CustomGameContentAlert.dart';
import 'package:drinkinggame/components/Dialogs.dart';
import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/pages/gamePages/neverHaveIEver/OpenQuestionPage.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/TruthOrDarePage.dart';
import 'package:drinkinggame/pages/mainMenuPages/DescriptionPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../App.dart';
import '../../model/games/Game.dart';
import '../../model/games/InfoGame.dart';
import '../../model/games/StatementGame.dart';
import '../../model/registers/RuleRegister.dart';
import '../../providers/DatabaseProvider.dart';
import '../../providers/GameProvider.dart';
import '../../services/database/Database.dart';
import 'InfoGamePage.dart';

///The page that is used to switch the game from one page to the other. It finds out what kind of game it is and redirects it.
class GameLandingPage extends ConsumerWidget{

  Database? _database;

  ///ENESTE STEDET I VERDEN VI SKAL BRUKE LATE
  late Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _database = ref.watch(databaseProvider);
    Widget widget = new CircularProgressIndicator();
    game = ref.read(gameProvider)!;
    RuleRegister ruleRegister = game.getRules();
    if(!ruleRegister.hasRules()){
      try{
        ref.watch(databaseProvider)?.getRulesForGame(game);
      }on StateError catch (e){
        Exception exception =  Exception(e.message);
        showExceptionAlertDialog(context, title: "Error loading game rules", exception: exception);
      }
    }
    switch(game.runtimeType){
      case InfoGame:
        widget = InfoGamePage(infoGame: game as InfoGame);
        break;
      case StatementGame:
        widget = TruthOrDarePage(statementGame: game as StatementGame,);
        break;
      case OpenQuestionGame:
        widget = OpenQuestionPage(openQuestionGame: game as OpenQuestionGame,);
        break;
    }
    return Scaffold(
      appBar: makeGameAppBar(context, game),
      drawer: DescriptionPage(game: game),
      body: widget,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => makeAlertDialog(context),
      ),
    );
  }

  ///Makes an custom item for that page.
  Future<void> makeCustomItem(BuildContext context) async {
    await makeAlertDialog(context);
  }

  ///Makes an alert dialog and shows it.
  ///[context] the build context.
  Future<void> makeAlertDialog(BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 400,
              child: CustomGameContentAlert(game: game,),
            ),
          );
        });
  }

}