import 'dart:ui';

import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import '../../model/games/Game.dart';

class GameButton extends CustomElevatedButton {

  ///Makes an instance of the GameButton.
  ///[game] the game
  ///[textColor] used to describe the color of the text used.
  ///[secondTextColor] for the color of subtext.
  GameButton({required Game game,
    required VoidCallback onPressed, Key? key})
      : super(
        widget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                game.getGameName(),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                game.getShortDescription(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        borderRadius:8.0,
        onPressed: onPressed,
        color: const Color(0xFFD9D9D9),
        height: 70,
        key: key,
  );
}
