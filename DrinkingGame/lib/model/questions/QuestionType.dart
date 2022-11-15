import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/questions/Question.dart';

///Represents the different question types.
enum QuestionType{

  ///Is a open question
  OPEN,

  ///Is a player question
  PLAYER,
}

///Extends the enum to introduce a method that identify the question.
extension QuestionIdentifier on QuestionType{

  ///Gets the type of the question
  ///[question] the question
  ///Returns the type of the question
  static QuestionType getQuestionType(Question question){
    QuestionType type = QuestionType.OPEN;
    if(question is Player){
      type = QuestionType.PLAYER;
    }
    return type;
  }

}