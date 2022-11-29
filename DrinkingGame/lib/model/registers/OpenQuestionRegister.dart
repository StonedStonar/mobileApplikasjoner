import 'dart:async';
import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';
import '../exceptions/CouldNotGetQuestionException.dart';
import '../questions/Question.dart';

///Represents a register for open questions which every player can answer.
class OpenQuestionRegister extends QuestionRegister<OpenQuestion>{

  bool used = false;

  StreamController<List<Question>> _streamController = StreamController();

  /// Checks to see if a question is used.
  /// returns true if question is used.
  bool isUsed() {
    return super.getRegisterItems().any((openQuestion) => !openQuestion.isUsed());
  }

  @override
  bool hasQuestions() {
    if(getRegisterItems().isNotEmpty){
      used = true;
    }
    return used;
  }


  ///Gets a question to display.
  ///Returns the question
  ///Throws [CouldNotGetQuestionException] if there is no question left for the player.
  OpenQuestion getRandomQuestionForPlayer() {
    if (hasQuestions()) {
      return getRegisterItems().first; //make it random. But shuffle did not work for me.
    } else {
      throw CouldNotGetQuestionException("There is no more questions in the register.");
    }
  }


  @override
  void updateStream() {
    _streamController.add(getRegisterItems());
  }

  @override
  Stream<List<DatabaseItem>> getStream() {
    _streamController.close();
    _streamController = StreamController();
    return _streamController.stream;
  }
}