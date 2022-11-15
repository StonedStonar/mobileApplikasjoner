import 'dart:async';
import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';

import '../questions/Question.dart';

///Represents a register for open questions which every player can answer.
class OpenQuestionRegister extends QuestionRegister{

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