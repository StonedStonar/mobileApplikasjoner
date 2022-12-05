import 'package:drinkinggame/components/CustomText.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/games/Game.dart';

class GameDonePage extends ConsumerWidget {
  ///Makes an instance of the finished game page.
  ///[game] the game
  GameDonePage({super.key, required this.game});

  Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomText(
              text: "No more questions",
              fontSize: 32,
              fontWeight: FontWeight.bold
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomText(
              text: "Thank you for playing ${game.getGameName()}.",
              fontSize: 24,
              fontWeight: FontWeight.normal
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CustomElevatedButton(
              widget: Text(
                "Exit game",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () => _navigateToLandingPage(context),
          ),
        ),
      ],
    );
  }

  ///Navigates to the landing page
  ///[context] the build context
  void _navigateToLandingPage(BuildContext context){
    Navigator.pushReplacementNamed(context, "/landingPage");
  }
}
