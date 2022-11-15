import 'dart:async';

import 'package:drinkinggame/model/StoreableItem.dart';

import '../Player.dart';
import 'Register.dart';

class PlayerRegister extends Register {

  final List<Player> _players = [];

  final StreamController<List<Player>> _streamController = StreamController();

  ///Adds a player to the register.
  ///[player] the player to be added
  ///Throws [Exception] if the player had trouble being added.
  void addPlayer(Player player) {
    if(!_players.contains(player)) {
      _players.add(player);
    } else {
      throw Exception("Player is already found in the register");
    }
  }

  ///Removes a player from the register.
  ///[player] the player to be removed.
  void removePlayer(Player player) {
    _players.remove(player);
  }

  ///Gets an iterator to go through players
  Iterator<Player> getIterator() {
    return _players.iterator;
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