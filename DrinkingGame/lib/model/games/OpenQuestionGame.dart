
import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';

///Represents a game where player answer yes or no to a statement.
class OpenQuestionGame extends Game {

  /// Makes an instance of open question game.
  /// [gameName] the game name
  /// [shortDescription] a short description of the game.
  /// [longDescription] a longer description of the game describing it in more detail.
  /// [chooseStatement] the text that should show when you are asked to add default questions.
  /// [statementName] the name of the statement to input.
  OpenQuestionGame({required super.gameName, required super.shortDescription, required super.longDescription, required String statementName}) :  _statementName = statementName;


  OpenQuestionRegister _playerQuestionRegister = OpenQuestionRegister();

  PlayerRegister _playerRegister = PlayerRegister();


  String _statementName;



  ///Gets the statement name
  ///Returns the statement name
  String getStatementName(){
    return _statementName;
  }

  ///Gets the game register.
  ///Returns a map with the game register.
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    map["statementName"] = _statementName;
    return map;
  }

  ///Gets the player register
  ///Returns the player register
  PlayerRegister getPlayerRegister() {
    return _playerRegister;
  }

  @override
  OpenQuestionRegister getGameRegister() {
    return _playerQuestionRegister;
  }

}
