
import 'package:drinkinggame/model/registers/QuestionRegister.dart';

///Represents a register for open questions which every player can answer.
class OpenQuestionRegister extends QuestionRegister{

  ///Checks if the question is already used.
  @override
  bool hasQuestions() {
    return super.getRegisterItems().any((openQuestion) => !openQuestion.isUsed());
  }





}