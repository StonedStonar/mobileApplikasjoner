
import 'dart:async';

import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';

import '../exceptions/CouldNotGetQuestionException.dart';

///Represents a register of questions made by player.
///When it comes to the register we add the question type in the diamond brackets.
class NeverHaveIEverRegister extends QuestionRegister<TruthOrDareQuestion> {

  StreamController<List<Question>> _streamController = StreamController();

  ///Check to see if there are questions in the register or not.
  ///Returns true if register has questions.
  @override
  bool hasQuestions() {
    return getRegisterItems().isNotEmpty && getRegisterItems().any((question) => !question.isUsed());
  }

  ///Shuffles the register
  void shuffleRegister(){
    getRegisterItems().shuffle();
  }

  ///Gets a random question for the player based on if they made it and if its used
  ///[player] the player.
  ///Returns the question
  ///Throws [CouldNotGetQuestionException] if there is no question left for the player.
  TruthOrDareQuestion getRandomQuestionForPlayer(Player player) {
    if (hasQuestions()) {
      return getRegisterItems().firstWhere((question) => question.getMadeBy() != player && !question.isUsed());
    } else {
      throw CouldNotGetQuestionException("There is no question for this user in the register.");
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
