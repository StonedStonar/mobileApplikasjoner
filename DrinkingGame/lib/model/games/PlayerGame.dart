import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/registers/PlayerQuestionRegister.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';

class PlayerGame extends Game {

  ///Makes an instance of the player game.
  ///[gameName] the name of the game.
  ///[shortDescription] the short description of the game.
  PlayerGame({required super.gameName, required super.shortDescription});

  PlayerQuestionRegister playerQuestionRegister = PlayerQuestionRegister(playerQuestions: []);
  PlayerRegister playerRegister = PlayerRegister();

  ///Gets the player register.
  PlayerRegister getPlayerRegister() {
    return playerRegister;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    return map;
  }

  @override
  PlayerQuestionRegister getGameRegister() {
    return playerQuestionRegister;
  }


}