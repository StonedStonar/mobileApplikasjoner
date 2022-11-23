import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/games/Game.dart';

class GameDonePage extends ConsumerWidget{

  ///Makes an instance of the finished game page.
  ///[game] the game
  GameDonePage({super.key, required this.game});

  Game game;



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Game is over"),
        Text("Do you want to play again?"),
      ],
    );
  }
}