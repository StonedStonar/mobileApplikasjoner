import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:drinkinggame/model/registers/Register.dart';

import '../registers/QuestionRegister.dart';


/// Represents an open question game
class OpenQuestionGame extends Game {
  /// Makes an instannce of open question game.
  /// [gameName] the game name
  /// [shortDescription] a short description of the game.
  /// [longDescription] a longer description of the game describing it in more detail.
  OpenQuestionGame({required super.gameName, required super.shortDescription, required super.longDescription});


  OpenQuestionRegister questionRegister = new OpenQuestionRegister();


  @override
  QuestionRegister getGameRegister() {
    return questionRegister;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapOfGame = getGameDetails();
    return mapOfGame;
  }

}