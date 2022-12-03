

import 'dart:collection';

import 'package:drinkinggame/model/enums/Response.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/model/registers/TruthOrDareRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/CustomText.dart';
import '../../../model/Player.dart';
import '../../../model/exceptions/CouldNotGetQuestionException.dart';
import '../../../model/games/StatementGame.dart';

class QuestionDisplayPage extends ConsumerStatefulWidget {

  ///Makes an instance of the question display page.
  ///[statementGame] the statement game
  ///[onDone] the action to do when its done.
  QuestionDisplayPage({required StatementGame statementGame, required VoidCallback onDone ,Key? key}) : _statementGame = statementGame,_onDone = onDone, super(key: key);

  StatementGame _statementGame;

  VoidCallback _onDone;


  StatementGame get statementGame => _statementGame;

  ///Executed when it is done.
  void doDone(){
    _onDone();
  }

  @override
  ConsumerState<QuestionDisplayPage> createState() => _QuestionDisplayPageState();

}

class _QuestionDisplayPageState extends ConsumerState<QuestionDisplayPage> {

  late Player _currentPlayer;

  bool _firstPlayer = true;

  TruthOrDareQuestion? truthOrDare;




  @override
  Widget build(BuildContext context) {
    if(_firstPlayer){
      _firstPlayer = false;
      _currentPlayer = widget.statementGame.getPlayerRegister().getRegisterItems().last;
      _getNextPlayer();
    }

    return Center(
      child: Column(
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      SizedBox(height: 60,),
      CustomText(text: _currentPlayer.getPlayerName(), fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: truthOrDare!.getTruthOrDare().name, fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: truthOrDare!.getQuestionText(), fontSize: 25, fontWeight: FontWeight.w300),
      SizedBox(height: 30,),
      CustomText(text: "Or..", fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: "Drink", fontSize: 25, fontWeight: FontWeight.w300),
      SizedBox(height: 30,),
      TextButton(onPressed: () => _nextQuestion(),
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

  ///Gets the next player and sets it.
  void _getNextPlayer(){
    PlayerRegister playerRegister = widget.statementGame.getPlayerRegister();
    TruthOrDareRegister truthReg = widget.statementGame.getGameRegister();
    int amountOfPlayers = playerRegister.getRegisterItems().length;
    int i = 0;
    truthOrDare = null;
    while(i < amountOfPlayers && truthOrDare == null){
      _currentPlayer = playerRegister.getNextPlayer(_currentPlayer);
      try{
        truthOrDare = truthReg.getRandomQuestionForPlayer(_currentPlayer);
      }on CouldNotGetQuestionException {
        truthOrDare = null;
      }
      i++;
    }
  }

  ///Gets the next question and updates the page.
  void _nextQuestion() {
    truthOrDare?.answerQuestion(Response.yes, _currentPlayer);
    _getNextPlayer();

    if(truthOrDare == null){
      widget.doDone();
    }else {
      setState(() {

      });
    }

  }
}
