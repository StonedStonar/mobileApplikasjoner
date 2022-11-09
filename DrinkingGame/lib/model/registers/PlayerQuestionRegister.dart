
import 'dart:math';

import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/questions/PlayerQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';

///Representes a register of questions made by player.
class PlayerQuestionRegister extends QuestionRegister {

  ///Makes an instance of playerQuestions.
  ///[playerQuestions] the playerQuestions.
  PlayerQuestionRegister({required List<PlayerQuestion> playerQuestions}) : this.playerQuestions = playerQuestions;

  List<PlayerQuestion> playerQuestions;
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



  ///Returns a random question for a specified player
  ///TODO fix this: only generates a random question, not for a specified user.
  Question getRandomQuestionForPlayer(player) {
    if (hasQuestions()) {
      return (getRegisterItems().toList()..shuffle()).first;
    } else {
      throw Exception("There is no elements in the list"); //prob npt necessary, since "first" throws an exception if list is empty.
    }
  }
}
