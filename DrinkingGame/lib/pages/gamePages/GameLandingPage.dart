import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/TruthOrDarePage.dart';
import 'package:drinkinggame/pages/mainMenuPages/DescriptionPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../App.dart';
import '../../model/games/Game.dart';
import '../../model/games/InfoGame.dart';
import '../../model/games/StatementGame.dart';
import '../../model/questions/InfoContainer.dart';
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
    switch(game.runtimeType){
      case InfoGame:
        widget = InfoGamePage(infoGame: game as InfoGame);
        break;
      case StatementGame:
        widget = TruthOrDarePage();
        break;
    }
    return Scaffold(
      appBar: makeGameAppBar(context, game),
      drawer: DescriptionPage(game: game),
      body: widget,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addCustomInfoContainer(context),
      ),
    );
  }

  ///Adds a custom info container so that the "store in database" is valid.
  ///[context] the build context.
  Future<void> addCustomInfoContainer(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController value = TextEditingController();
    await makeAlertDialog(controller,descriptionController, value,context);
    if(controller.text.isNotEmpty && descriptionController.text.isNotEmpty){
      InfoContainer infoContainer = InfoContainer(containerId: value.text, title: controller.text, description: descriptionController.text);
      print(infoContainer.toMap());
      await _database?.setItemForGame(game,infoContainer);
    }
  }

  ///Makes an alert dialog and shows it.
  ///[controller] the controller of the game name.
  ///[description] the controller for description.
  ///[value] the value controller.
  ///[context] the build context.
  Future<void> makeAlertDialog(TextEditingController contoller, TextEditingController description, TextEditingController value, BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Make custom game"),
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  TextField(
                    controller: contoller,
                    decoration: InputDecoration(
                      hintText: "Input title",
                    ),
                  ),
                  TextField(
                    controller: description,
                    decoration: InputDecoration(
                        hintText: "Input "
                    ),
                  ),
                  TextField(
                    controller: value,
                    decoration: InputDecoration(
                        hintText: "Value "
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Add")),
            ],
          );
        });
  }

}