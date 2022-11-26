import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/GameSlidingButton.dart';
import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/enums/GameType.dart';
import 'package:drinkinggame/model/games/InfoGame.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';
import 'package:drinkinggame/model/registers/GameRegister.dart';
import 'package:drinkinggame/pages/gamePages/GameLandingPage.dart';
import 'package:drinkinggame/pages/gamePages/InfoGamePage.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/TruthOrDarePage.dart';
import 'package:drinkinggame/services/database/Database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/overlays/MainMenu.dart';
import '../providers/DatabaseProvider.dart';
import '../providers/GameProvider.dart';
import '../providers/GameRegisterProvider.dart';

///TODO: Hører ikke hjemme her. Putt i egen fil.
enum MenuItem {firstItem, secondItem, thirdItem}


class GameSelectionPage extends ConsumerWidget {


  GameSelectionPage({Key? key}) : super(key: key);

  Database? database;

  GameRegister? gameRegister;

  WidgetRef? widgetRef;

  GameType gameType = GameType.INFO;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    database = ref.watch(databaseProvider);
    gameRegister = ref.watch(gameRegisterProvider);
    widgetRef = ref;

    database?.getGames(gameRegister!);
    return StreamBuilder<List<Game>?>(
        stream: gameRegister?.getStream(),
        builder: (context, snapshot){
          List<Widget> widgets = [];
          if(snapshot.hasData){
            snapshot.data?.forEach((game) => addGameToList(game, widgets, context));
          }
          return Scaffold(
            appBar: makeNormalAppBar("Games", context),
            body: _contentOfGamePage(context, widgets),
            drawer: MainMenu(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => addCustomGame(context),
            ),
          );
        });
  }

  ///Adds a custom game so that the "store in database" is valid.
  ///[context] the build context.
  Future<void> addCustomGame(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    await makeAlertDialog(controller, context);
    if(controller.text.isNotEmpty){
      Game game = InfoGame(gameName: controller.text, shortDescription: "", longDescription: "Hei");
      switch(gameType){
        case GameType.OPEN:
          break;
        case GameType.TRUTHORDARE:
          game = StatementGame(gameName: controller.text, shortDescription: "", longDescription: "Hei");
          break;
      }
      await database?.setCustomGame(game);
      gameRegister?.getRegisterItems().clear();
      Navigator.pushNamed(context, "/landingPage");
    }
  }

  ///Makes an alert dialog and shows it.
  ///[controller] the controller of the game name.
  ///[description] the controller for description.
  ///[context] the build context.
  Future<void> makeAlertDialog(TextEditingController contoller, BuildContext context) async{
    List<GameType> gameTypes = [];
    gameTypes.add(GameType.INFO);
    gameTypes.add(GameType.TRUTHORDARE);
    gameTypes.add(GameType.OPEN);
    List<DropdownMenuItem<GameType>> chooseWidgets = [];
    gameTypes.forEach((type) {
      chooseWidgets.add(DropdownMenuItem<GameType>(
        child: Text(type.name),

        value: type,
      ));
    });
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Make custom game"),
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  TextField(
                    controller: contoller,
                    decoration: InputDecoration(
                        hintText: "Input game name"
                    ),
                  ),
                  DropdownButton<GameType>(
                      items: chooseWidgets,
                      onChanged: (type){
                        gameType = type!;
                      },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Add"))
            ],
          );
        });
  }

  ///Adds a game to the list.
  ///[game] the game to add.
  ///[games] the games.
  ///[context] the build context.
  void addGameToList(Game game, List<Widget> games, BuildContext context){
    games.add(SizedBox(height: 16.0));
    games.add(GameSlidingButton(
      game: game,
      onPressed: () {
        widgetRef?.read(gameProvider.notifier).state = game;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GameLandingPage()));
      },
    ),
    );

  }

  ///Makes the content of the game page.
  ///[context] the build context.
  ///Returns the widget
  Widget _contentOfGamePage(BuildContext context, List<Widget> gameWidgets) {
    return ListView(
      dragStartBehavior: DragStartBehavior.start,
      scrollDirection: Axis.vertical,
      children: gameWidgets,
    );
  }
}
