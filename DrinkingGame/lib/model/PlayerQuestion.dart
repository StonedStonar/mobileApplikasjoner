

import 'package:drinkinggame/model/Questions.dart';
import 'package:drinkinggame/services/enums/Response.dart';

import 'Player.dart';

class PlayerQuestion extends Questions {
  Response? response;
  Player? madeBy;
  Player? respondant;

  Response? getResponse() {
    return response;
  }

  Player? getMadeBy() {
    return madeBy;
  }

  Player? getRespondant() {
    return respondant;
  }

  bool? isUSed() {

  }

  void answerQuestion(Response response, Player player) {
    this.response = response;
    this.madeBy = player;
    print("Answer to question: " + response.toString(), );
  }
}