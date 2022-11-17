


import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/TruthOrDareRegister.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';
import '../Player.dart';
import '../enums/Response.dart';


///Represents a questions made by a player.
class TruthOrDareQuestion extends Question {

  ///Makes an instance of playerQuestions.
  ///[playerQuestions] the playerQuestions.
  TruthOrDareQuestion({required super.questionText, required super.questionId, required Response response, required Player madeBy})
  : _response = response, _madeBy = madeBy;

  Response _response;
  Player _madeBy;
  Player? _respondant;


  ///Gets response
  Response getResponse() {
    return _response;
  }

  ///Gets made by
  Player getMadeBy() {
    return _madeBy;
  }

  ///Gets respondant
  Player? getRespondant() {
    return _respondant;
  }

  ///Prints the answer to a question
  void answerQuestion(Response response, Player player) {
    this._response = response;
    this._madeBy = player;
  }


  ///Checks if a question is already used.
  ///Returns true if the question is used.
  @override
  bool isUsed() {
    return _respondant != null;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getQuestionMap();
    return map;
  }
}