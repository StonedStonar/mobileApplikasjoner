
import 'package:drinkinggame/model/registers/QuestionRegister.dart';

///Represents a register for open questions which every player can answer.
class OpenQuestionRegister extends QuestionRegister{

  bool used = false;

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
}