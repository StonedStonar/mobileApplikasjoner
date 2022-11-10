

import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:drinkinggame/model/registers/Register.dart';

///Represents a game where player answer yes or no to a statement.
class StatementGame extends Game {

  ///Makes an instance of
  StatementGame({required super.rules, required super.gameName, required super.shortDescription, required List<OpenQuestion> openQuestion})
  : _openQuestion = openQuestion;

  List<OpenQuestion> _openQuestion;
  OpenQuestionRegister _openQuestionRegister;


  ///Gets an open question
  @override
  List<OpenQuestion> getOpenQuestions(){
  return _openQuestion;
  }


  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  @override
  Register getGameRegister() {
    // TODO: implement getGameRegister
    throw UnimplementedError();
  }
}