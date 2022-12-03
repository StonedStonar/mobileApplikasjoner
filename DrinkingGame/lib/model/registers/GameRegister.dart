import 'dart:async';

import 'package:drinkinggame/model/exceptions/CouldNotAddGameException.dart';
import 'package:drinkinggame/model/exceptions/CouldNotRemoveGameException.dart';
import 'package:drinkinggame/model/registers/Register.dart';

import '../games/Game.dart';

///Represents a game register. It holds all the games that is loaded into the application.
class GameRegister extends Register{

  List<Game> _games = [];

  StreamController<List<Game>> _streamController = StreamController();

  ///Adds a game to the register.
  ///[game] the game to add
  ///Throws [CouldNotAddGameException] if the game could not be added.
  void addGame(Game game){
    if(!_games.contains(game) && !_games.any((registerGame) => registerGame.getItemId() == game.getItemId())){
      _games.add(game);
    }else{
      throw CouldNotAddGameException("The game could not be added");
    }
  }

  ///Removes a game from the register.
  ///[game] game to remove
  ///Throws [CouldNotRemoveGameException] if the game is not in the register.
  void removeGame(Game game){
    if(!_games.remove(game)){
      throw CouldNotRemoveGameException("The game could not be found");
    }
  }

  @override
  List<Game> getRegisterItems() {
    return _games;
  }

  @override
  Stream<List<Game>> getStream() {
    _streamController.close();
    _streamController = StreamController();
    return _streamController.stream;
  }

  @override
  void updateStream() {
    _streamController.add(_games);
  }


}