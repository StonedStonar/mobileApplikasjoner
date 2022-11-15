import 'package:drinkinggame/model/StoreableItem.dart';
class Player extends DatabaseItem {

  int _playerID;
  String _playerName;

  ///Makes an instance of a player
  ///[playerID] the unique id of the player
  ///[playerName] the name of the player
  Player({required int playerID, required String playerName}) : assert(playerName.isNotEmpty), assert(playerID > 0), _playerID = playerID, _playerName = playerName;

  Player.fromMap({required Map<String, dynamic> map}) : assert(map.length == 2), _playerID = int.parse(map["playerID"]), _playerName = map["playerName"];

  ///Gets the player name
  ///Returns the players name
  String getPlayerName() {
    return _playerName;
  }

  @override
  String getItemId() {
    return _playerID.toString();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "playerID" : _playerID,
      "playerName" : _playerName,
    };
  }

}