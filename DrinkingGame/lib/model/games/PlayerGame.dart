import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/registers/TruthOrDareRegister.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';

///Todo: Da fuq is this class - Steinar 2022
class PlayerGame extends Game {

  ///Makes an instance of the player game.
  ///[gameName] the name of the game.
  ///[shortDescription] the short description of the game.
  PlayerGame({required super.gameName, required super.shortDescription});

  TruthOrDareRegister _playerQuestionRegister = TruthOrDareRegister();
  PlayerRegister _playerRegister = PlayerRegister();

  ///Gets the player register.
  ///Returns player register
  PlayerRegister getPlayerRegister() {
    return _playerRegister;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    return map;
  }

  @override
  TruthOrDareRegister getGameRegister() {
    return _playerQuestionRegister;
  }


}