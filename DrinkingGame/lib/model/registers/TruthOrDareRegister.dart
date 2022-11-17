
import 'dart:async';

import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';

///Represents a register of questions made by player.
///When it comes to the register we add the question type in the diamond brackets.
class TruthOrDareRegister extends QuestionRegister<TruthOrDareQuestion> {
  
  StreamController<List<Question>> _streamController = StreamController();

  ///Check to see if there are questions in the register or not.
  ///Returns true if register has questions.
  @override
  bool hasQuestions() {
    return getRegisterItems().isNotEmpty && getRegisterItems().any((question) => question.isUsed());
  }

  ///Shuffles the register
  void shuffleRegister(){
    getRegisterItems().shuffle();
  }

  ///Gets a random question for the player based on if they made it and if its used
  ///Returns the question
  Question getRandomQuestionForPlayer(player) {
    if (hasQuestions()) {
      return getRegisterItems().firstWhere((question) => question.getMadeBy() != player && !question.isUsed());
    } else {
      ///Todo: En "CouldNotGetQuestionException" er bedre.
      throw Exception("There is no elements in the list"); //prob not necessary, since "first" throws an exception if list is empty.
    }
  }

  @override
  void updateStream() {
    _streamController.close();
    _streamController = StreamController();
    _streamController.add(getRegisterItems());
  }

  @override
  Stream<List<Question>> getStream() {
    return _streamController.stream;
  }
}
