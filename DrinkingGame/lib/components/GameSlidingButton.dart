

import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/buttons/GameButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/games/Game.dart';

class GameSlidingButton extends ConsumerWidget {

  GameSlidingButton({required this.game, Color textColor = Colors.black, required this.onPressed}) : _textColor = textColor;

  Game game;

  VoidCallback onPressed;

  Color _textColor;

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
            widget: text, borderRadius: 8.0, onPressed: () => _updateGame(context), color: Colors.green, height: 70,
        )
      ],
    );
  }

  Widget buildContent(){
    return GameButton(game: game, onPressed: onPressed, textColor: _textColor);
  }

  void _updateGame(BuildContext context){
    ref?.watch(databaseProvider)?.updateGame(game);
    Navigator.pushNamed(context, "/landingPage");
  }


}