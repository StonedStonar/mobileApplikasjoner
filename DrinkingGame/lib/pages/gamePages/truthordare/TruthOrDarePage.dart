import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/PlayerInputPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/games/Game.dart';

class TruthOrDarePage extends ConsumerWidget {

  TruthOrDarePage({super.key});

  StatementGame? statementGame;

  PlayerRegister? playerRegister;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    statementGame = StatementGame(gameName: "Truth or dare", shortDescription: "hei");
    // TODO: implement build
    return Scaffold(
      appBar: makeGameAppBar(context, statementGame!),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PlayerInputPage()
        ),
      ),
    );
  }



  Widget _buildPlayersAddedField() {
    return Card(

    );
  }
}