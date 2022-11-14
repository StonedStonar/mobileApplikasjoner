import 'dart:async';

import 'package:drinkinggame/model/exceptions/CouldNotAddQuestionException.dart';
import 'package:drinkinggame/model/exceptions/CouldNotRemoveQuestionException.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/Register.dart';

import '../StoreableItem.dart';

///Represents a question register.
abstract class QuestionRegister extends Register{

  final List<Question> _questions = [];

  StreamController<Question> _stream = StreamController();

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

  ///Removes a question from the register, and adds it to askedQuestions list.
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

  @override
  List<Question> getRegisterItems() {
    return _questions;
  }
}