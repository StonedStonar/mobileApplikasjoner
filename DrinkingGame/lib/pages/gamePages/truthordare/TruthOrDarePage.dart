import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/ContinueQuestionPage.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/InputPlayersInputPage.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/InputQuestionsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/forms/ContinueQuestionForm.dart';
import '../../../model/games/Game.dart';
import '../../../model/games/InfoGame.dart';
import 'Inputs/TruthOrDarePageEnum.dart';


class TruthOrDarePage extends ConsumerStatefulWidget {

  //Uncomment statement game parameter later.
  TruthOrDarePage({required this.statementGame, super.key});

  StatementGame statementGame;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TruthOrDareState();
}

class _TruthOrDareState extends ConsumerState<TruthOrDarePage> {

  int number = 0;

  Widget widgetToShow = InputPlayersInputPage();

  @override
  Widget build(BuildContext context) {

    return widgetToShow;
  }

  Widget _makeContiunueForm(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 70, 15, 5),
      child: ContinueQuestionForm(mainTitle: 'Do you want to add truth(s) or dare(s)?',
        subTitle: 'If nor truth or dares is added only a default question set will be used',
        yesFunction: _changeToInputQuestions,
        noFunction: ,
      ),
    );
  }

  void _changeToInputQuestions(){
    widgetToShow = InputQuestionsPage();
  }

  void _changeToPlay(){
    widgetToShow = QuestionDisplay();
  }


}