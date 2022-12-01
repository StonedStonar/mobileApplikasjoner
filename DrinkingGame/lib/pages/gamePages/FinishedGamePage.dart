import 'package:drinkinggame/components/CustomText.dart';
import 'package:flutter/cupertino.dart';
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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
              text: "Game over",
              fontSize: 32,
              fontWeight: FontWeight.bold
          ),
          CustomText(
              text: "Do you want to play again?",
              fontSize: 24,
              fontWeight: FontWeight.normal
          ),
        ],
      ),
    );
  }
}
