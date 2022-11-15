import 'package:drinkinggame/model/questions/Question.dart';

class OpenQuestion extends Question {

  ///Makes an instance of the open question
  ///[questionId] the id of the question
  ///[questionText] the question text
  OpenQuestion({required super.questionText, required super.questionId});

  ///Makes an instance of the open question with the map
  ///[map] the map
  OpenQuestion.fromMap(Map<String, dynamic> map) : super(questionText: map["questionText"], questionId: map["questionId"]);

  bool used = false;


  @override
  bool isUsed() {
    //TODO implement method
    return used;
  }


  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getQuestionMap();
    return map;
  }
}
