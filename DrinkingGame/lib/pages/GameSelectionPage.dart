

import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/Dialogs.dart';
import 'package:drinkinggame/components/buttons/GameButton.dart';
import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/games/InfoGame.dart';
import 'package:drinkinggame/pages/gamePages/InfoGamePage.dart';
import 'package:drinkinggame/services/database/Database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/overlays/MainMenu.dart';

///TODO: Hører ikke hjemme her. Putt i egen fil.
enum MenuItem {firstItem, secondItem, thirdItem}


class GameSelectionPage extends ConsumerWidget {


  GameSelectionPage({Key? key}) : super(key: key);

  Database? database;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    database = ref.watch(databaseProvider);
    return StreamBuilder<List<Game>>(
        stream: database?.getGames(),
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
    TextEditingController descriptionController = TextEditingController();
    await makeAlertDialog(controller,descriptionController, context);
    if(controller.text.isNotEmpty && descriptionController.text.isNotEmpty){
      Game game = InfoGame(rules: [], gameName: controller.text, shortDescription: descriptionController.text);
      await database?.setCustomGame(game);
    }
  }

  ///Makes an alert dialog and shows it.
  ///[controller] the controller of the game name.
  ///[description] the controller for description.
  ///[context] the build context.
  Future<void> makeAlertDialog(TextEditingController contoller, TextEditingController description, BuildContext context) async{
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
                  TextField(
                    controller: description,
                    decoration: InputDecoration(
                        hintText: "Input description"
                    ),
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
    Widget gamePage = InfoGamePage(infoGame: game as InfoGame);
    games.add(SizedBox(height: 16.0));
    games.add(GameButton(
      game: game,
      onPressed: () => _openPage(gamePage, context),
    ),
    );

  }

  ///Makes the content of the game page.
  ///[context] the build context.
  ///Returns the widget
  Widget _contentOfGamePage(BuildContext context, List<Widget> gameWidgets) {
    return Column(
      children: gameWidgets,
    );
  }

  ///Opens a new page.
  ///[widget] widget to open on a new page.
  ///[context] the build context.
  void _openPage(Widget widget, BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
  }
}
