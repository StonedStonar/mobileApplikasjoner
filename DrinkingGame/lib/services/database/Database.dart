

import 'package:drinkinggame/model/Rule.dart';
import 'package:drinkinggame/model/StoreableItem.dart';

import '../../model/games/Game.dart';
import '../../model/registers/GameRegister.dart';

abstract class Database{

  ///Creates a new game.
  ///[game] the new game.
  Future<void> setCustomGame(Game game);

  ///Gets all the games
  ///Returns a stream with all the games.
  Future<void> getGames(GameRegister gameRegister);

  ///Sets an item for a game.
  ///[game] the game to set
  ///[databaseItem] the item
  Future<void> setItemForGame(Game game, DatabaseItem databaseItem);

  ///Gets the items of the game.
  ///[game] the game.
  Future<void> getContentsOfGame(Game game);

  ///Updates the chosen game.
  ///[game] the game to update.
  Future<void> updateGame(Game game);

  ///Sets a rule for a game.
  ///[game] the game.
  ///[rule] the rule
  Future<void> setRuleForGame(Game game, Rule rule);
}