
///Represents an abstract class of questions.
abstract class Questions {

  String? questionText;

  ///Gets the questions as a string.
  String? getQuestionText() {
    return questionText;
  }

  ///Check to see if the question is used or not.
  bool? isUsed(){}
}
