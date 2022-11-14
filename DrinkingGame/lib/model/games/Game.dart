import 'package:drinkinggame/model/registers/Register.dart';

import '../Rule.dart';
import '../StoreableItem.dart';

abstract class Game extends DatabaseItem {

  ///Makes an instance of the game.
  ///[rules] the list of rules for the game.
  ///[gameName] the game name.
  ///[shortDescription] the short description.
  Game({required List<Rule> rules, required String gameName, required String shortDescription}) : _rules = rules,
        _gameName = gameName, _shortDescription = shortDescription;

  final List<Rule> _rules;

  final String _gameName;

  final String _shortDescription;


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

  ///Gets the rules of the game.
  ///return a list with the rules.
  List<Rule> getRules(){
    return _rules;
  }

  ///Gets the rules as a map.
  ///Returns a list with all the rules as a map.
  List<Map<String, dynamic>> getRulesAsMap(){
    List<Map<String, dynamic>> rulesAsDatabaseItems = [];
    _rules.forEach((rule) => rulesAsDatabaseItems.add(rule.toMap()));
    return rulesAsDatabaseItems;
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
    };
  }

  ///Gets the game register.
  Register getGameRegister();
}