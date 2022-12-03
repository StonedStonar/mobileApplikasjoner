

import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/Dialogs.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/buttons/GameButton.dart';
import 'package:drinkinggame/services/database/FirestoreDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/games/Game.dart';
import '../providers/DatabaseProvider.dart';

class GameSlidingButton extends ConsumerWidget {

  ///Makes an instance of the game sliding button
  ///[game] the game the button belongs to.
  ///[onPressed] the on pressed function
  GameSlidingButton({required this.game, required this.onPressed});

  Game game;

  VoidCallback onPressed;

  WidgetRef? ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    return Slidable(
      closeOnScroll: true,
      endActionPane: buildBehindMenu(context),
      child: buildContent(),
    );
  }

  ///Builds the content behind the main content.
  ///[context] the context
  ///Returns the action pane.
  ActionPane buildBehindMenu(BuildContext context){
    Text text = Text(
        "Update game",
        style: TextStyle(
          color: Colors.white,
        ),
    );
    return ActionPane(
      motion: BehindMotion(),
      children: [
        CustomElevatedButton(
            widget: text, onPressed: () => _updateGame(context), color: Colors.green, height: 70,
        )
      ],
    );
  }

  ///Builds the main content of the widget
  ///Returns the widget
  Widget buildContent(){
    return GameButton(game: game, onPressed: onPressed,);
  }

  ///Updates the game from firebase.
  ///[context] the build context
  Future<void> _updateGame(BuildContext context) async {
    try{
      await ref?.watch(databaseProvider)?.updateGame(game);
      Navigator.pushNamed(context, "/landingPage");
    }on StateError catch (e) {
      Exception exception =  Exception(e.message);
      showExceptionAlertDialog(context, title: "Error updating game", exception: exception);
    }
  }


}