import 'package:drinkinggame/model/enums/Response.dart';
import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:drinkinggame/model/registers/TruthOrDareRegister.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/model/registers/Register.dart';

///Represents a game where player answer yes or no to a statement.
class StatementGame extends Game {

  ///Makes an instance of
  StatementGame({required super.gameName, required super.shortDescription});

  TruthOrDareRegister _playerQuestionRegister = TruthOrDareRegister();

  PlayerRegister _playerRegister = PlayerRegister();

  ///Gets the game register.
  ///Returns a map with the game register.
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    return map;
  }


  ///Gets the player register
  ///Returns the player register
  PlayerRegister getPlayerRegister(){
    return _playerRegister;
  }

  @override
  TruthOrDareRegister getGameRegister() {
    return _playerQuestionRegister;
  }
}