import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';
import 'package:drinkinggame/model/registers/Register.dart';

///Represents a register for open questions.
class OpenQuestionRegister extends QuestionRegister{

  @override
  bool hasQuestions() {
    return super.getRegisterItems().any((openQuestion) => !openQuestion.isUsed());
  }


}