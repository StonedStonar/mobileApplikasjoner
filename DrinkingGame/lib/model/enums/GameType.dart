import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';

///Represents the game type as an enum.
enum GameType{
  ///Is an info game.
  INFO,

  ///Is a player based game.
  TRUTHORDARE,

  ///Is an open question game.
  OPEN,

  ///Is a Never Have I Ever game
  //NEVERHAVEIEVER,
}

///Extends the enum to introduce a method that can identify the game.
extension GameTypeIdentifier on GameType{

  ///Gets the type of the game.
  ///[game] the game to get the type of.
  ///Returns what type of game it is.
  static GameType getGameType(Game game){
    GameType gameType = GameType.INFO;
    switch(game.runtimeType){
      case StatementGame:
        gameType = GameType.TRUTHORDARE;
        break;
      ///Todo: Add more games here later.
      default: break;
    }
    return gameType;
  }
}