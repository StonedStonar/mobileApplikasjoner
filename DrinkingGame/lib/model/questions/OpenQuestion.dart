import 'package:drinkinggame/model/questions/Question.dart';

class OpenQuestion extends Question {

  OpenQuestion({required super.questionText, required super.questionId});

  ///Ikke bruk spørsmålstegn i koden når du ikke skal ha null verider der.
  bool? used = false;

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
