

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../App.dart';
import '../../components/AppBars.dart';
import '../../components/InfoGameCard.dart';
import '../../model/StoreableItem.dart';
import '../../model/questions/InfoContainer.dart';
import '../../model/registers/InfoContainerRegister.dart';
import '../../model/games/InfoGame.dart';
import '../../services/database/Database.dart';

///Represents a info game that is shown.
class InfoGamePage extends ConsumerWidget {

  ///Makes an instance of the game page.
  ///[infoGame] the game.
  InfoGamePage({required this.infoGame});

  Database? _database;

  bool recivedItem = true;

  final InfoGame infoGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _database = ref.watch(databaseProvider);
    InfoContainerRegister infoContainerRegister = infoGame.getGameRegister();
    _database?.getContentsOfGame(infoGame);
    return StreamBuilder<List<InfoContainer>?>(
        stream: infoContainerRegister.getStream(),
        builder: (context, container){
          List<Widget> widgets = [];
          if(container.hasData){
            container.data!.forEach((container) {
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: infoCards,
        ),
      ),
    );
  }
}
