import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/registers/PlayerQuestionRegister.dart';

class PlayerGame extends Game {

  ///Makes an instance of the player game.
  ///[gameName] the name of the game.
  ///[shortDescription] the short description of the game.
  PlayerGame({required super.gameName, required super.shortDescription});

  PlayerQuestionRegister playerQuestionRegister = PlayerQuestionRegister(playerQuestions: []);

  @override
  PlayerQuestionRegister getGameRegister() {
    return playerQuestionRegister;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    return map;
  }


}