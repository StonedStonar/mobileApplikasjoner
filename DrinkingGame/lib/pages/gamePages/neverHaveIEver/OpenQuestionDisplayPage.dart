

import 'dart:collection';

import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/model/registers/TruthOrDareRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/CustomText.dart';
import '../../../model/Player.dart';
import '../../../model/exceptions/CouldNotGetQuestionException.dart';
import '../../../model/games/StatementGame.dart';

class OpenQuestionDisplayPage extends ConsumerStatefulWidget {

  OpenQuestionDisplayPage({required OpenQuestionGame openQuestionGame, required VoidCallback onDone ,Key? key})
      : _openQuestionGame = openQuestionGame,_onDone = onDone, super(key: key){
    _openQuestionGame.getPlayerRegister().getRegisterItems().forEach((player) => playedMap[player] = false);
  }


  OpenQuestionGame _openQuestionGame;

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

class _QuestionDisplayPageState extends ConsumerState<OpenQuestionDisplayPage> {

  late Player _currentPlayer;

  bool _firstPlayer = true;

  TruthOrDareQuestion? truthOrDare;

  OpenQuestion? openQuestion;


  @override
  Widget build(BuildContext context) {
    if(_firstPlayer){
      _firstPlayer = false;
      _currentPlayer = widget.openQuestionGame.getPlayerRegister().getRegisterItems().last;
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
    PlayerRegister playerRegister = widget.openQuestionGame.getPlayerRegister();
    HashMap<Player, bool> playedMap = widget.playedMap;
    int amountOfPlayers = playerRegister.getRegisterItems().length;
    int i = 0;
    bool hasQuestions = false;
    while(!hasQuestions && i < amountOfPlayers){
      _currentPlayer = playerRegister.getNextPlayer(_currentPlayer);
      playedMap[_currentPlayer] = hasQuestions;
      i++;
    }
  }


  ///Gets the next question and updates the page.
  void _nextQuestion() {
    bool done = widget.playedMap.values.every((done) => done);
    if(!done){
      _getNextPlayer();
    }
    if(done || openQuestion == null){
      widget.doDone();
    }else {
      setState(() {

      });
    }

  }
}
