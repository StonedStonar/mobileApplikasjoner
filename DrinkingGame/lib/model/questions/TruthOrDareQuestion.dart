


import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/TruthOrDareRegister.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';
import '../Player.dart';
import '../enums/Response.dart';
import '../enums/TruthOrDare.dart';


///Represents a questions made by a player.
class TruthOrDareQuestion extends Question {

  ///Makes an instance of playerQuestions.
  ///[playerQuestions] the playerQuestions.
  TruthOrDareQuestion({required super.questionText, required super.questionId, Response response = Response.undefined, required Player madeBy, required TruthOrDare truthOrDare})
      : _response = response, _madeBy = madeBy, _truthOrDare = truthOrDare;

  Response _response;

  Player _madeBy;

  Player? _respondant;

  TruthOrDare _truthOrDare;

  ///Gets if its a truth or dare.
  ///Returns if its a truth or dare.
  TruthOrDare getTruthOrDare(){
    return _truthOrDare;
  }

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
    map.addAll({"truthOrDare" : _truthOrDare});
    return map;
  }
}