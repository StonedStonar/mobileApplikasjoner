

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

  QuestionDisplayPage({required StatementGame statementGame, required VoidCallback onDone ,Key? key}) : _statementGame = statementGame,_onDone = onDone, super(key: key){
    _statementGame.getPlayerRegister().getRegisterItems().forEach((player) => playedMap[player] = false);
  }

  StatementGame _statementGame;

  VoidCallback _onDone;

  HashMap<Player, bool> playedMap = new HashMap();

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
    HashMap<Player, bool> playedMap = widget.playedMap;
    int amountOfPlayers = playerRegister.getRegisterItems().length;
    int i = 0;
    bool hasQuestions = false;
    while(!hasQuestions && i < amountOfPlayers){
      _currentPlayer = playerRegister.getNextPlayer(_currentPlayer);
      if(!playedMap[_currentPlayer]!){
        hasQuestions = !_getNextQuestion();
      }
      playedMap[_currentPlayer] = hasQuestions;

      i++;
    }
  }

  ///Gets the next question
  ///Returns true if the player has next question. False otherwise.
  bool _getNextQuestion(){
    bool done = false;
    TruthOrDareRegister truthReg = widget.statementGame.getGameRegister();
    try{

      truthOrDare = truthReg.getRandomQuestionForPlayer(_currentPlayer);
    }on CouldNotGetQuestionException{
      done = true;
      truthOrDare = null;
    }
    return done;
  }

  ///Gets the next question and updates the page.
  void _nextQuestion() {
    bool done = widget.playedMap.values.every((done) => done);
    truthOrDare?.answerQuestion(Response.yes, _currentPlayer);
    if(!done){
      _getNextPlayer();
    }
    if(done || truthOrDare == null){
      widget.doDone();
    }else {
      setState(() {

      });
    }

  }
}
