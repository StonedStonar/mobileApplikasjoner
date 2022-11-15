import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/questions/PlayerQuestion.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:drinkinggame/model/registers/Register.dart';

///Represents a game where player answer yes or no to a statement.
class StatementGame extends Game {

  ///Makes an instance of
  StatementGame({required super.gameName, required super.shortDescription});

  OpenQuestionRegister _openQuestionRegister = OpenQuestionRegister();


  ///Gets an open question
  @override
  OpenQuestionRegister getOpenQuestions(){
  return _openQuestionRegister;
  }

  ///Gets the game register.
  ///Returns a map with the game register.
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    _openQuestionRegister.add(PlayerQuestion(questionText: "Question 1", questionId: "1", response: "Response1", madeBy: "madeBy1"));
    _openQuestionRegister.add(PlayerQuestion(questionText: "Question 2", questionId: "2", response: "Response2", madeBy: "madeBy2"));
    return map;
  }


  @override
  OpenQuestionRegister getGameRegister() {
    // TODO: implement getGameRegister
    return _openQuestionRegister;
  }
}