
import 'package:drinkinggame/model/StoreableItem.dart';

///Represents an abstract class of questions.
abstract class Question extends DatabaseItem{

  ///Makes an instance of the questions
  ///[questionText] the question text.
  ///[questionId] the id of the question.
  Question({required String questionText, required String questionId}) : _questionId = questionId, _questionText = questionText;

  String _questionText;

  String _questionId;

  ///Gets the questions as a string.
  ///Returns the question text
  String getQuestionText() {
    return _questionText;
  }

  ///Gets the question as a map.
  ///Returns a map of the question.
  Map<String, dynamic> getQuestionMap(){
    return {
      "questionText":_questionText,
      "questionId" : _questionId,
    };
  }

  ///Check to see if the question is used or not.
  bool isUsed();

  @override
  String getItemId() {
    return _questionId;
  }
}
