import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/pages/gamePages/neverHaveIEver/Inputs/InputOpenQuestionsPage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import '../../../components/forms/ContinueQuestionForm.dart';
import '../../../providers/DatabaseProvider.dart';
import '../FinishedGamePage.dart';
import 'OpenQuestionDisplayPage.dart';

///Represents the open question game page, the first page the players are presented playing this game, and are asked if the wants to add some questions themselves.
class OpenQuestionPage extends ConsumerStatefulWidget {
  OpenQuestionPage({required this.openQuestionGame, super.key});


  ///The open question game.
  OpenQuestionGame openQuestionGame;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpenQuestionPageState();

}

///Represents TODO
class _OpenQuestionPageState extends ConsumerState<OpenQuestionPage> {

  int number = 0;

  ///Is true if question have not been asked before
  bool _firstTime = true;

  ///The widget to show
  Widget widgetToShow = new Container();

  @override
  Widget build(BuildContext context) {
    if(_firstTime){
      widgetToShow = _makeContinueForm();
      _firstTime = false;
    }
    return widgetToShow;
  }

  ///Builds a form, where players can add their own open questions.
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

  ///Updates state to play-mode, and redirect to game-site.
  void _changeToInputQuestions(){
    widget.openQuestionGame.getGameRegister().getRegisterItems().clear();
    _updateThisState(InputOpenQuestionsPage(openQuestionRegister: widget.openQuestionGame.getGameRegister(),onDone: _changeToPlay,));

  }

  /// Starting game with questions from the database
  Future<void> _changeToPlayWithDBQuestions() async {
    await ref.watch(databaseProvider)?.getContentsOfGame(widget.openQuestionGame);
    _changeToPlay();
  }

  ///Updates state to play-mode with self-made questions
  void _changeToPlay(){
    _updateThisState(OpenQuestionDisplayPage(openQuestionGame: widget.openQuestionGame, onDone: _changeToFinish));
  }

  ///Changes state of widget to game finished, and redirects to GameDonePage.
  void _changeToFinish(){
    _updateThisState(GameDonePage(game: widget.openQuestionGame));
  }

  ///Shows the desired widget
  ///[widget] the widget to show.
  void _updateThisState(Widget widget){
    setState(() {
      widgetToShow = widget;
    });
  }

}