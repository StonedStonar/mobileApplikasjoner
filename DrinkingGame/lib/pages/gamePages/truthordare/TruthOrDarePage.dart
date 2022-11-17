import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/CustomPlayersInputPage.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/CustomQuestionsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/games/Game.dart';
import '../../../model/games/InfoGame.dart';

class TruthOrDarePage extends ConsumerWidget {

  TruthOrDarePage({super.key});

  ///TODO: remove!!
  InfoGame? infoGame;

  StatementGame? statementGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///TODO: remove!!
    infoGame = InfoGame(gameName: "Spill", shortDescription: "Kult spill");
    statementGame = StatementGame(gameName: "Truth or dare", shortDescription: "hei");
    return Scaffold(
      appBar: makeGameAppBar(context, statementGame!),
      body: Container(
          child: CustomQuestionsInputPage()
      ),
    );
  }



  Widget _buildPlayersAddedField() {
    return Card(

    );
  }
}