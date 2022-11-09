import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';
import 'package:drinkinggame/model/questions/PlayerQuestion.dart';

///Representes a register of questions made by player.
class PlayerQuestionRegister extends QuestionRegister {

  bool isRegisterEmpty = false;

  ///Check to see if there are questions in the register or not.
  ///Returns true if register has questions.
  @override
  bool hasQuestions() {
    if (super.getRegisterItems().any((PlayerQuestion) => PlayerQuestion.getQuestionMap().isEmpty)) {
      isRegisterEmpty = true;
    }
    return isRegisterEmpty;
  }



  //PlayerQuestion getRandomQuestionForPlayer(player)
}
