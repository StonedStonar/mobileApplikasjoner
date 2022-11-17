import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/ContinueQuestionPage.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/CustomPlayersInputPage.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/CustomQuestionsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/games/Game.dart';
import '../../../model/games/InfoGame.dart';

class TruthOrDarePage extends ConsumerWidget {

  //Uncomment statement game parameter later.
  TruthOrDarePage({/*StatementGame statementGame ,*/ super.key}) /*: _statementGame = statementGame*/;

  StatementGame _statementGame = StatementGame(gameName: "Truth or dare", shortDescription: "hei", longDescription: "far far away");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: makeGameAppBar(context, _statementGame),
      body: Container(
          child: ContinueQuestionPage()
      ),
    );
  }

  Widget _buildPlayersAddedField() {
    return Card(

    );
  }
}