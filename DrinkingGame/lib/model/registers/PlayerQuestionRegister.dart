
import 'dart:async';

import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/questions/PlayerQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/QuestionRegister.dart';

///Representes a register of questions made by player.
class PlayerQuestionRegister extends QuestionRegister {


  ///Makes an instance of playerQuestionsRegister.
  ///Todo: Trenger ikke å ta inn noe siden vi har arvet det fra question register klassen.
  PlayerQuestionRegister({required List<PlayerQuestion> playerQuestions}) : this.playerQuestions = playerQuestions;

  List<PlayerQuestion> playerQuestions;
  
  StreamController<List<Question>> _streamController = StreamController();


  ///Check to see if there are questions in the register or not.
  ///Returns true if register has questions.
  @override
  bool hasQuestions() {
    return playerQuestions.isNotEmpty;
  }



  ///Returns a random question for a specified player
  Question getRandomQuestionForPlayer(player) {
    if (hasQuestions()) {
      ///Todo: skal returnere et spørsmål som denne playeren ikke har laget selv men samtidig ikke er besvart.
      return (playerQuestions.toList()).first;
    } else {
      throw Exception("There is no elements in the list"); //prob not necessary, since "first" throws an exception if list is empty.
    }
  }

  @override
  void updateStream() {
    _streamController.add(getRegisterItems());
  }

  @override
  Stream<List<Question>> getStream() {
    return _streamController.stream;
  }
}
