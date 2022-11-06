import 'StoreableItem.dart';

abstract class Game extends DatabaseItem {

  ///Makes an instance of the game.
  ///[rules] the list of rules for the game.
  ///[gameName] the game name.
  ///[shortDescription] the short description.
  Game({required List<String> rules, required String gameName, required String shortDescription}) : _rules = rules,
        _gameName = gameName, _shortDescription = shortDescription;

  List<String> _rules;

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
  List<String> getRules(){
    return _rules;
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
}