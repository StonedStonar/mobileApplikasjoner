import 'package:drinkinggame/model/registers/Register.dart';
import 'package:drinkinggame/model/registers/RuleRegister.dart';

import '../Rule.dart';
import '../StoreableItem.dart';

abstract class Game extends DatabaseItem {

  ///Makes an instance of the game.
  ///[gameName] the game name.
  ///[shortDescription] the short description.
  ///[_longDescription] the long description of the game describing it more in detail.
  Game({required String gameName, required String shortDescription, required String longDescription}) :
        _gameName = gameName, _shortDescription = shortDescription, _longDescription = longDescription;

  final RuleRegister _ruleRegister = RuleRegister();

  final String _gameName;

  final String _shortDescription;

  final String _longDescription;

  ///Gets the name of the game.
  ///Returns the game name.
  String getGameName(){
    return _gameName;
  }

  ///Gets the short description
  ///Returns the short description.
  String getShortDescription(){
    return _shortDescription;
  }

  ///Gets the long description
  ///Returns the long description
  String getLongDescription(){
    return _longDescription;
  }

  ///Gets the rules of the game.
  ///return a list with the rules.
  RuleRegister getRules(){
    return _ruleRegister;
  }

  @override
  String getItemId() {
    return _gameName;
  }

  ///Gets the game details.
  ///Returns a map with the games details.
  Map<String, dynamic> getGameDetails(){
    return {
      "gameName" : _gameName,
      "shortDescription" : _shortDescription,
      "longDescription" : _longDescription,
    };
  }

  ///Gets the game register.
  Register getGameRegister();
}