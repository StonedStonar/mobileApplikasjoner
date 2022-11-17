import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/questions/InfoContainer.dart';

import '../registers/InfoContainerRegister.dart';

///Represents an information game that shows its contents as containers
class InfoGame extends Game{

  ///Makes an instance of the info game.
  ///[gameName] the name of the game.
  ///[shortDescription] the short description of the game.
  InfoGame({required super.gameName, required super.shortDescription});

  InfoContainerRegister _infoContainerRegister = InfoContainerRegister();

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    return map;
  }

  @override
  InfoContainerRegister getGameRegister() {
    return _infoContainerRegister;
  }
}