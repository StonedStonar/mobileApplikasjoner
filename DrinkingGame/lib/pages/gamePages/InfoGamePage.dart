

import 'package:drinkinggame/pages/mainMenuPages/DescriptionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../App.dart';
import '../../components/AppBars.dart';
import '../../components/InfoGameCard.dart';
import '../../model/questions/InfoContainer.dart';
import '../../model/registers/InfoContainerRegister.dart';
import '../../model/games/InfoGame.dart';
import '../../model/registers/Register.dart';
import '../../services/database/Database.dart';

///Represents a info game that is shown.
class InfoGamePage extends ConsumerWidget {

  ///Makes an instance of the game page.
  ///[infoGame] the game.
  InfoGamePage({required this.infoGame});

  Database? _database;

  final InfoGame infoGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _database = ref.watch(databaseProvider);
    InfoContainerRegister infoContainerRegister = infoGame.getGameRegister();
    return StreamBuilder<List<InfoContainer>?>(
        stream: infoContainerRegister.getStream(),
        builder: (context, list){
          Register register =infoGame.getGameRegister();
          if(register.getRegisterItems().isEmpty){
            _database?.getContentsOfGame(infoGame);
          }else{
            register.updateStream();
          }
          List<Widget> widgets = [];
          if(list.hasData){
            list.data!.sort((a,b) => int.parse(a.getItemId()).compareTo(int.parse(b.getItemId())));
            list.data!.forEach((container) {
              widgets.add(InfoGameCard(infoContainer: container));
              widgets.add(SizedBox(height: 10));
            });
          }else{
            widgets.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                )
            );
          }
          return Scaffold(
            appBar: makeGameAppBar(context, infoGame),
            body: _makeContent(widgets),
            floatingActionButton: FloatingActionButton(
              onPressed: () => addCustomInfoContainer(context),
              child: Icon(Icons.add),
            ),
            drawer: DescriptionPage(game: infoGame),
          );
        }

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
      await _database?.setItemForGame(infoGame,infoContainer);
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

  ///Makes the content for the info game page.
  ///[infoCards] is the widgets needed
  Widget _makeContent(List<Widget> infoCards) {
    return ListView(
      scrollDirection: Axis.vertical,
      clipBehavior: Clip.antiAlias,
      dragStartBehavior: DragStartBehavior.down,
      padding: EdgeInsets.all(10),
      children: infoCards,
    );
  }
}
