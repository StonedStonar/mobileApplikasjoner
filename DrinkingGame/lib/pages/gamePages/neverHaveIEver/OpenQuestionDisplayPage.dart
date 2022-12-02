
import 'dart:collection';
import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/CustomText.dart';
import '../../../model/Player.dart';

///Represents open question display page, where the players are presented with questions to answer.
class OpenQuestionDisplayPage extends ConsumerStatefulWidget {

  ///Makes an instance of open question display page.
  ///[openQuestionGame] The first page the players see when playing the game.
  ///[onDone] Callback called when players are done with the questions.
  OpenQuestionDisplayPage({required OpenQuestionGame openQuestionGame, required VoidCallback onDone ,Key? key})
      : _openQuestionGame = openQuestionGame,_onDone = onDone, super(key: key){
    _openQuestionGame.getPlayerRegister().getRegisterItems().forEach((player) => playedMap[player] = false);
  }


  ///The game
  OpenQuestionGame _openQuestionGame;

  ///Callback for when question has been answered
  VoidCallback _onDone;

  HashMap<Player, bool> playedMap = new HashMap();

  OpenQuestionGame get openQuestionGame => _openQuestionGame;

  ///Executed when it is done.
  void doDone(){
    _onDone();
  }

  @override
  ConsumerState<OpenQuestionDisplayPage> createState() => _QuestionDisplayPageState();

}

///Represents a state in question display page.
class _QuestionDisplayPageState extends ConsumerState<OpenQuestionDisplayPage> {

  ///The current question
  late OpenQuestion _currentQuestion;

  ///Boolean to show if a question has been asked before.
  bool _firstTime = true;

  @override
  Widget build(BuildContext context) {

    if(_firstTime){
      _nextQuestion();
      _firstTime = false;
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildChildren(),
    );
  }

  ///Build the content of the page
  List<Widget> _buildChildren() {
    return [
      SizedBox(height: 60,),
      CustomText(text: widget.openQuestionGame.getStatementName(), fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: _currentQuestion.getQuestionText(), fontSize: 25, fontWeight: FontWeight.w300),
      SizedBox(height: 30,),
      CustomText(text: "Or..", fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: "Drink", fontSize: 25, fontWeight: FontWeight.w300),
      SizedBox(height: 30,),
      TextButton(
          onPressed: _nextQuestionUpdate,
          child: Column(
            children: const [
              SizedBox(height: 5),
              Icon(CupertinoIcons.arrow_right, size: 60),
              Text("Next",
                style: TextStyle(fontSize: 25),)
            ],
          )),
    ];
  }


  ///Opens the next question
  void _nextQuestion(){
    OpenQuestionRegister openQuestionRegister = widget.openQuestionGame.getGameRegister();
    if(openQuestionRegister.hasQuestions()){
      _currentQuestion = openQuestionRegister.getRandomQuestion();
      _currentQuestion.setUsed();
    }else{
      widget.doDone();
    }
  }

  void _nextQuestionUpdate(){
    _nextQuestion();
    setState(() {});
  }
}
