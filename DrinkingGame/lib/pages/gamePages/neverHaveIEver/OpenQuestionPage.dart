import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/pages/gamePages/neverHaveIEver/Inputs/InputOpenQuestionsPage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import '../../../components/forms/ContinueQuestionForm.dart';
import '../FinishedGamePage.dart';
import '../truthordare/Inputs/InputPlayersInputPage.dart';
import 'OpenQuestionDisplayPage.dart';


class OpenQuestionPage extends ConsumerStatefulWidget {
  //OpenQuestionPage({required this.openQuestionGame, required VoidCallback onDone, Key? key});
  OpenQuestionPage({required this.openQuestionGame, super.key});


  OpenQuestionGame openQuestionGame;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NeverHaveIEverState();

}

class _NeverHaveIEverState extends ConsumerState<OpenQuestionPage> {

  int number = 0;

  bool _firstTime = true;

  Widget widgetToShow = Container();

  @override
  Widget build(BuildContext context) {
    if(_firstTime){
      widgetToShow = InputPlayersInputPage(playerRegister:widget.openQuestionGame.getPlayerRegister(), onDone: _makeContinueForm);
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
    _updateThisState(InputOpenQuestionsPage(openQuestionRegister: widget.openQuestionGame.getGameRegister(),onDone: _changeToPlay,));

  }

  void _changeToPlay(){
    _updateThisState(OpenQuestionDisplayPage(openQuestionGame: widget.openQuestionGame, onDone: _changeToFinish));
  }

  void _changeToFinish(){
    _updateThisState(GameDonePage(game: widget.openQuestionGame));
  }

  void _updateThisState(Widget widget){
    setState(() {
      widgetToShow = widget;
    });
  }

}