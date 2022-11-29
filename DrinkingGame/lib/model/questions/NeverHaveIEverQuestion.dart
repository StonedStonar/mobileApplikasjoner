


import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/TruthOrDareRegister.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';
import '../Player.dart';
import '../enums/Response.dart';
import '../enums/TruthOrDare.dart';


///Represents a questions made by a player.
class NeverHaveIEverQuestion extends Question {

  ///Makes an instance of playerQuestions.
  ///[playerQuestions] the playerQuestions.
  NeverHaveIEverQuestion({required super.questionText, required super.questionId, Response response = Response.undefined, required Player madeBy})
      : _response = response, _madeBy = madeBy;

  Response _response;

  Player _madeBy;

  Player? _respondant;



  ///Gets response
  ///Returns the response
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
    return _response != Response.undefined;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getQuestionMap();
    return map;
  }
}