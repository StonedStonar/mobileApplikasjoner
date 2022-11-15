import 'package:drinkinggame/model/Player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerNotifier extends StateNotifier<List<Player>> {
  PlayerNotifier(): super([]);

  void addPlayerToRegister(Player player) {
    state = [...state, player];
  }
}