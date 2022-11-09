

import 'package:drinkinggame/model/questions/Question.dart';

import '../Player.dart';
import '../enums/Response.dart';

class PlayerQuestion extends Question {

  ///Makes an instance of the questions
  ///[questionText] the question text.
  ///[questionId] the id of the question.

  PlayerQuestion({required super.questionText, required super.questionId, required response, required madeBy, required respondant})
      : response = response, madeBy = madeBy, respondant = respondant;

  Response response;
  Player madeBy;
  Player respondant;


  ///Gets response
  Response getResponse() {
    return response;
  }

  ///Gets who made the question
  Player getMadeBy() {
    return madeBy;
  }

  ///Gets respondant
  Player getRespondant() {
    return respondant;
  }

  ///Prints an answer to a question made by player.
  void answerQuestion(Response response, Player player) {
    this.response = response;
    this.madeBy = player;
    print("Answer to question: " + response.toString(), );
  }

  @override
  bool isUsed() {
    // TODO: implement isUsed
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}