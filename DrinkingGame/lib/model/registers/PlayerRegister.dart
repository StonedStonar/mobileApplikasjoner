import 'dart:async';

import 'package:drinkinggame/model/StoreableItem.dart';

import '../Player.dart';
import 'Register.dart';

///Represents the player Register.
class PlayerRegister extends Register {

  final List<Player> _players = [];

  StreamController<List<Player>> _streamController = StreamController();

  ///Adds a player to the register.
  ///[player] the player to be added
  ///Throws [Exception] if the player is already in the register.
  void addPlayer(Player player) {
    if(!_players.contains(player)) {
    _players.add(player);
    } else {
      throw Exception("The player is already found in the register");
    }
  }

  ///Removes a player from the register.
  ///[player] the player to be removed.
  void removePlayer(Player player) {
    if (_players.contains(player)) {
      _players.remove(player);
    } else {
      throw Exception("Player could not be removed form the register");
    }
  }

  ///Gets a player by their id.
  ///[playerID] the id of the player.
  ///Returns the player who matches the id.
  ///Throws [StateError] is thrown when there is no player with that id.
  Player getPlayerById(int playerID){
    Iterator<Player> it = _players.iterator;
    Player? playerFound = null;
    while(it.moveNext() && playerFound == null){
      Player player = it.current;
      if(int.parse(player.getItemId()) == playerID){
        playerFound = player;
      }
    }
    if(playerFound == null){
      throw StateError("Player not found");
    }
    return playerFound!;
  }

  ///Gets the next player.
  ///[playerID] the player
  ///Returns the next player
  Player getNextPlayer(Player player){
    return _players[(_players.indexOf(player) + 1) % _players.length];
  }

  ///Gets an iterator to go through players
  ///Returns the iterator of the players
  Iterator<Player> getIterator() {
    return _players.iterator;
  }

  @override
  List<Player> getRegisterItems() {
    return _players;
  }

  @override
  Stream<List<DatabaseItem>> getStream() {
    _streamController.close();
    _streamController = StreamController();
    return _streamController.stream;
  }

  @override
  void updateStream() {
    _streamController.add(_players);
  }
}