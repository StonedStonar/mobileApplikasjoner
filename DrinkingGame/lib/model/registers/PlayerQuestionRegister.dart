
import 'package:drinkinggame/model/questions/PlayerQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';

///Representes a register of questions made by player.
class PlayerQuestionRegister extends QuestionRegister {


  ///Makes an instance of playerQuestions.
  ///[playerQuestions] the playerQuestions.
  PlayerQuestionRegister({required List<PlayerQuestion> playerQuestions}) : this.playerQuestions = playerQuestions;

  List<PlayerQuestion> playerQuestions;


  ///Check to see if there are questions in the register or not.
  ///Returns true if register has questions.
  @override
  bool hasQuestions() {
    return playerQuestions.isNotEmpty;
  }



  ///Returns a random question for a specified player
  Question getRandomQuestionForPlayer(player) {
    if (hasQuestions()) {
      return (playerQuestions.toList()).first;
    } else {
      throw Exception("There is no elements in the list"); //prob not necessary, since "first" throws an exception if list is empty.
    }
  }
}
