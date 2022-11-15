import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/games/Game.dart';

class TruthOrDarePage extends ConsumerWidget {

  TruthOrDarePage({required this.statementGame,super.key});

  StatementGame statementGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: makeGameAppBar(context, statementGame),
      body: Container(
        child: Text(statementGame.getGameName()),
      ),
    );
  }


  Widget _buildPlayersAddedField() {
    return Card(

    );
  }
}