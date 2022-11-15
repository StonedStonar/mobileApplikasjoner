import 'dart:async';

import 'package:drinkinggame/model/StoreableItem.dart';

import '../Player.dart';
import 'Register.dart';

///Represents the player Register.
class PlayerRegister extends Register {

  final List<Player> _players = [];

  final StreamController<List<Player>> _streamController = StreamController();

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
    if(_players.contains(player)) {
      _players.remove(player);
    } else {
      throw Exception("Player could not be removed form the register");
    }
  }

  void removePlayerById(int id) {
      var it = _players.iterator;
      while (it.moveNext()) {
        if(it.current.getPlayerId() == id) {
          removePlayer(it.current);
          break;
        }
      }
  }

  ///Gets an iterator to go through players
  Iterator<Player> getIterator() {
    return _players.iterator;
  }

  ///Returns a list of players
  List<Player> getPlayers() {
    return _players;
  }

  @override
  List<DatabaseItem> getRegisterItems() {
    return _players;
  }

  @override
  Stream<List<DatabaseItem>> getStream() {
    return _streamController.stream;
  }

  @override
  void updateStream() {
    _streamController.add(_players);
  }
}