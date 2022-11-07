import 'package:drinkinggame/model/questions/Question.dart';

class OpenQuestion extends Question {

  OpenQuestion({required super.questionText, required super.questionId});

  bool used = false;

  @override
  bool isUsed() {
    return used;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getQuestionMap();
    return map;
  }
}
