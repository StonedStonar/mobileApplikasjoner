import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/pages/gamePages/neverHaveIEver/Inputs/InputOpenQuestionsPage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import '../../../components/forms/ContinueQuestionForm.dart';
import '../../../providers/DatabaseProvider.dart';
import '../FinishedGamePage.dart';
import '../truthordare/Inputs/InputPlayersInputPage.dart';
import 'OpenQuestionDisplayPage.dart';


class OpenQuestionPage extends ConsumerStatefulWidget {
  //OpenQuestionPage({required this.openQuestionGame, required VoidCallback onDone, Key? key});
  OpenQuestionPage({required this.openQuestionGame, super.key});


  OpenQuestionGame openQuestionGame;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpenQuestionPageState();

}

class _OpenQuestionPageState extends ConsumerState<OpenQuestionPage> {

  int number = 0;

  bool _firstTime = true;

  Widget widgetToShow = new Container();

  @override
  Widget build(BuildContext context) {
    if(_firstTime){
      widgetToShow = _makeContinueForm();
      _firstTime = false;
    }
    return widgetToShow;
  }

  Widget _makeContinueForm(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 70, 15, 5),
      child: ContinueQuestionForm(mainTitle: 'Do you want to add some "Never have I Evers"?',
        subTitle: 'No worries, we have already some statements to use if you are not so creative <3 ',
        yesFunction: _changeToInputQuestions,
        noFunction: () => _changeToPlayWithDBQuestions(),
      ),
    );
  }

  void _changeToInputQuestions(){
    widget.openQuestionGame.getGameRegister().getRegisterItems().clear();
    _updateThisState(InputOpenQuestionsPage(openQuestionRegister: widget.openQuestionGame.getGameRegister(),onDone: _changeToPlay,));

  }

  Future<void> _changeToPlayWithDBQuestions() async {
    await ref.watch(databaseProvider)?.getContentsOfGame(widget.openQuestionGame);
    _changeToPlay();
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