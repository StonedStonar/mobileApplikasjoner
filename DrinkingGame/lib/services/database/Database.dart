

import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/questions/InfoContainer.dart';
import 'package:drinkinggame/model/registers/InfoContainerRegister.dart';

import '../../model/games/Game.dart';

abstract class Database{

  ///Creates a new game.
  ///[game] the new game.
  Future<void> setCustomGame(Game game);

  ///Gets all the games
  ///Returns a stream with all the games.
  Stream<List<Game>> getGames();

  ///Gets the items of the game.
  ///[game] the game.
  ///Returns a stream that is the content of the game, that can be questions.
  Stream<List<DatabaseItem>> getContentsOfGame(Game game);
}