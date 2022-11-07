

import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/questions/InfoContainer.dart';
import 'package:drinkinggame/model/registers/InfoContainerRegister.dart';

import '../model/games/Game.dart';

abstract class Database{


  ///Creates a new infoContainer or adds it
  ///[infoContainer] infoContainer to add.
  Future<void> setInfoContainer(InfoContainer infoContainer);

  ///Reads all the info containers form the database.
  ///Returns a stream with InfoContainerRegister.
  Stream<InfoContainerRegister> readInfoContainer();

  ///Creates a new game.
  ///[game] the new game.
  Future<void> setCustomGame(Game game);

  ///Gets all the games
  ///Returns a stream with all the games.
  Stream<List<Game>> getGames();

  ///Gets the items of the game.
  ///[gameId] the id of the game.
  ///Returns a stream that is the content of the game, that can be questions.
  Stream<List<DatabaseItem>> getContentsOfGame(String gameId);
}