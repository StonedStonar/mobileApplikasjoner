import 'dart:async';

import 'package:drinkinggame/model/exceptions/CouldNotAddQuestionException.dart';
import 'package:drinkinggame/model/exceptions/CouldNotRemoveQuestionException.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/Register.dart';

import '../StoreableItem.dart';

///Represents a question register.
///The "T" in this case is the object that extends the class Question. Its called generic class.
///This question register can now contain anything that extends the question class.
abstract class QuestionRegister<T extends Question> extends Register{

  final List<T> _questions = [];

  ///Adds a question to the question register.
  ///[question] the question to add.
  ///Throws [CouldNotAddQuestionException] if the question is already in the register.
  void add(T question){
    if(!_questions.contains(question)){
      _questions.add(question);
    }else{
      throw CouldNotAddQuestionException("The question is already in the register");
    }
  }

  ///Removes a question from the register, and adds it to askedQuestions list.
  ///[question] the question to remove.
  ///Throws [CouldNotRemoveQuestionException] if the question is not in the register.
  void remove(T question){
    if(!_questions.remove(question)){
      throw CouldNotRemoveQuestionException("The question could not be removed");
    }
  }

  ///Checks if the register has questions left.
  ///Returns true if the register has questions.
  bool hasQuestions();

  @override
  List<T> getRegisterItems() {
    return _questions;
  }
}