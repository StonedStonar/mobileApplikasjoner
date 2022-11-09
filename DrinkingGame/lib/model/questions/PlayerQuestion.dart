

import 'package:drinkinggame/model/questions/Question.dart';

import '../Player.dart';
import '../enums/Response.dart';

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

  @override
  bool isUsed() {
    // TODO: implement isUsed
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getQuestionMap();
    return map;
  }
}