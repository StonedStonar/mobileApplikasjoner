
import 'dart:js_util';


import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/PlayerQuestionRegister.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';
import '../Player.dart';
import '../enums/Response.dart';


///Represents a questions made by a player.
class PlayerQuestion extends Question {

  ///Makes an instance of playerQuestions.
  ///[playerQuestions] the playerQuestions.
  PlayerQuestion({required super.questionText, required super.questionId, required response, required madeBy, required respondant})
  : response = response, madeBy = madeBy, respondant = respondant;

  Response response;
  Player madeBy;
  Player respondant;


  ///Gets response
  Response getResponse() {
    return response;
  }

  ///Gets made by
  Player getMadeBy() {
    return madeBy;
  }

  ///Gets respondant
  Player getRespondant() {
    return respondant;
  }

  ///Prints the answer to a question
  void answerQuestion(Response response, Player player) {
    this.response = response;
    this.madeBy = player;
    print("Answer to question: " + response.toString(), );
  }


  ///Checks if a question is already used.
  ///Returns true if the question is used.
  ///TODO needs to be modified, contains a bug. What should be used as key, my brain if fried. Is there a better way to do this?
  @override
  bool isUsed() {
    bool value = false;
    if (toMap().containsKey(Question)){
      value = true;
    }
    return value;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getQuestionMap();
    return map;
  }
}