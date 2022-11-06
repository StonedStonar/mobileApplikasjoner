import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/model/Game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoGamePage extends ConsumerWidget{

  ///Makes an instance of the game page.
  ///[game] the game.
  InfoGamePage({required this.game});

  Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: makeGameAppBar(context, game),
      body: _makeContent(),
    );
  }

  Widget _makeContent(){
    return Column(
      children: [

      ],
    );
  }

}