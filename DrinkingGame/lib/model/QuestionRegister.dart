import 'package:drinkinggame/model/exceptions/CouldNotAddQuestionException.dart';
import 'package:drinkinggame/model/exceptions/CouldNotRemoveQuestionException.dart';
import 'package:drinkinggame/model/questions/Question.dart';

///Represents a question register.
abstract class QuestionRegister{

  final List<Question> _questions = [];

  ///Adds a question to the question register.
  ///[question] the question to add.
  ///Throws [CouldNotAddQuestionException] if the question is already in the register.
  void add(Question question){
    if(!_questions.contains(question)){
      _questions.add(question);
    }else{
      throw CouldNotAddQuestionException("The question is already in the register");
    }
  }

  ///Removes a question from the register.
  ///[question] the question to remove.
  ///Throws [CouldNotRemoveQuestionException] if the question is not in the register.
  void remove(Question question){
    if(_questions.remove(question)){
      throw CouldNotRemoveQuestionException("The question could not be removed");
    }
  }

  ///Checks if the register has questions left.
  ///Returns true if the register has questions.
  bool hasQuestions();

  ///Gets all the questions of this register.
  ///Returns all the questions.
  List<Question> getAllQuestions(){
    return _questions;
  }
}