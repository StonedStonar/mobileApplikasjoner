

import 'package:drinkinggame/model/StoreableItem.dart';

import '../../model/games/Game.dart';

abstract class Database{

  ///Creates a new game.
  ///[game] the new game.
  Future<void> setCustomGame(Game game);

  ///Gets all the games
  ///Returns a stream with all the games.
  Stream<List<Game>> getGames();

  ///Sets an item for a game.
  ///[game] the game to set
  ///[databaseItem] the item
  Future<void> setItemForGame(Game game, DatabaseItem databaseItem);

  ///Gets the items of the game.
  ///[game] the game.
  Future<void> getContentsOfGame(Game game);
}