import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import '../../../components/forms/ContinueQuestionForm.dart';
import '../../../model/games/StatementGame.dart';
import '../FinishedGamePage.dart';
import '../truthordare/Inputs/InputPlayersInputPage.dart';
import '../truthordare/Inputs/InputQuestionsPage.dart';
import '../truthordare/QuestionDisplayPage.dart';


class NeverHaveIEverPage extends ConsumerStatefulWidget {
  NeverHaveIEverPage({required this.statementGame, super.key});

  StatementGame statementGame;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NeverHaveIEverState();

}

class _NeverHaveIEverState extends ConsumerState<NeverHaveIEverPage> {

  int number = 0;

  bool _firstTime = true;

  Widget widgetToShow = Container();

  @override
  Widget build(BuildContext context) {
    if(_firstTime){
      widgetToShow = InputPlayersInputPage(playerRegister:widget.statementGame.getPlayerRegister(), onDone: _makeContinueForm);
      _firstTime = false;
    }
    return widgetToShow;
  }

  void _makeContinueForm(){
    _updateThisState(Padding(
      padding: const EdgeInsets.fromLTRB(15, 70, 15, 5),
      child: ContinueQuestionForm(mainTitle: 'Do you want to add some "Never have I Evers"?',
        subTitle: 'If none are provided, a default statements set will be used',
        yesFunction: _changeToInputQuestions,
        noFunction: _changeToPlay,
      ),
    ));
  }

  void _changeToInputQuestions(){
    _updateThisState(InputQuestionsPage(playerRegister: widget.statementGame.getPlayerRegister(), truthOrDareRegister: widget.statementGame.getGameRegister(),onDone: _changeToPlay,));
    //_updateThisState(InputQuestionsPage(playerRegister: widget.statementGame.getPlayerRegister(), questionRegister: widget.statementGame.getGameRegister(), onDone: _changeToPlay,))
  }

  void _changeToPlay(){
    _updateThisState(QuestionDisplayPage(statementGame: widget.statementGame, onDone: _changeToFinish));
  }

  void _changeToFinish(){
    _updateThisState(GameDonePage(game: widget.statementGame));
  }

  void _updateThisState(Widget widget){
    setState(() {
      widgetToShow = widget;
    });
  }

}