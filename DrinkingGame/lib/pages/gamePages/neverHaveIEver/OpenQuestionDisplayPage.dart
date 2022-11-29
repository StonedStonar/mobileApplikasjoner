

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

  late OpenQuestion _currentQuestion;

  bool _firstTime = true;

  @override
  Widget build(BuildContext context) {

    if(_firstTime){
      _nextQuestion();
      _firstTime = false;
    }
    
    return Column(
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    return [
      SizedBox(height: 60,),
      CustomText(text: "Never have i ever", fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: _currentQuestion.getQuestionText(), fontSize: 25, fontWeight: FontWeight.w300),
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


  void _nextQuestion(){
    OpenQuestionRegister openQuestionRegister = widget.openQuestionGame.getGameRegister();
    if(openQuestionRegister.hasQuestions()){
      _currentQuestion = openQuestionRegister.getRandomQuestion();
      ///Change this later if you want to record the result
      _currentQuestion.setUsed();
      setState(() {});
    }else{
      widget.doDone();
    }
  }
}
