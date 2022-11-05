

import 'package:drinkinggame/model/questions/Question.dart';

import '../Player.dart';
import '../enums/Response.dart';

class PlayerQuestion extends Question {

  ///Ikke bruk spørsmålstegn i koden når du ikke skal ha null verider der.
  Response? response;
  ///Ikke bruk spørsmålstegn i koden når du ikke skal ha null verider der.
  Player? madeBy;

  Player? respondant;


  PlayerQuestion({required super.questionText, required super.questionId});

  ///Ikke bruk spørsmålstegn i koden når du ikke skal ha null verider der.
  Response? getResponse() {
    return response;
  }

  ///Ikke bruk spørsmålstegn i koden når du ikke skal ha null verider der.
  Player? getMadeBy() {
    return madeBy;
  }

  ///Ikke bruk spørsmålstegn i koden når du ikke skal ha null verider der.
  Player? getRespondant() {
    return respondant;
  }

  ///Ikke bruk spørsmålstegn i koden når du ikke skal ha null verider der.
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