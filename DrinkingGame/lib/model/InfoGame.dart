import 'package:drinkinggame/model/Game.dart';

class InfoGame extends Game{

  ///Makes an instance of the info game.
  ///[rules] the rules of the game.
  ///[gameName] the name of the game.
  ///[shortDescription] the short description of the game.
  InfoGame({required super.rules, required super.gameName, required super.shortDescription});

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();

    return map;
  }

}