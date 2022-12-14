import 'package:drinkinggame/pages/gamePages/FinishedGamePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/forms/ContinueQuestionForm.dart';
import '../../../model/games/StatementGame.dart';
import 'Inputs/InputPlayersInputPage.dart';
import 'Inputs/InputQuestionsPage.dart';
import 'QuestionDisplayPage.dart';

class TruthOrDarePage extends ConsumerStatefulWidget {

  ///Makes an instance of the truth or dare page.
  ///[statementGame] the statement game
  TruthOrDarePage({required this.statementGame, super.key});

  StatementGame statementGame;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TruthOrDareState();
}

class _TruthOrDareState extends ConsumerState<TruthOrDarePage> {

  int number = 0;

  bool _firstTime = true;

  Widget widgetToShow = Container();

  @override
  Widget build(BuildContext context) {
    if(_firstTime){
      widget.statementGame.getPlayerRegister().getRegisterItems().clear();
      widgetToShow = InputPlayersInputPage(playerRegister:widget.statementGame.getPlayerRegister(), onDone: _changeToInputQuestions);
      _firstTime = false;
    }
    return widgetToShow;
  }

  ///Changes to input questions.
  void _changeToInputQuestions(){
    _updateThisState(InputQuestionsPage(playerRegister: widget.statementGame.getPlayerRegister(), truthOrDareRegister: widget.statementGame.getGameRegister(),onDone: _changeToPlay,));
  }

  ///Changes to play
  void _changeToPlay(){
    _updateThisState(QuestionDisplayPage(statementGame: widget.statementGame, onDone: _changeToFinish));
  }

  ///Changes to finish
  void _changeToFinish(){
    _updateThisState(GameDonePage(game: widget.statementGame));
  }

  ///Updates the state of this page
  void _updateThisState(Widget widget){
    setState(() {
      widgetToShow = widget;
    });
  }



}