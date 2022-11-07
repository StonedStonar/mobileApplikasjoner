import 'package:drinkinggame/model/games/Game.dart';

enum GameType{
  INFO,
  PLAYER,
  OPEN,
}

extension GameTypeIdentifier on GameType{

  ///Gets the type of the game.
  ///[game] the game to get the type of.
  ///Returns what type of game it is.
  static GameType getGameType(Game game){
    GameType gameType = GameType.INFO;
    switch(game.runtimeType){
      ///Todo: Add more games here later.
      default: break;
    }
    return gameType;
  }
}