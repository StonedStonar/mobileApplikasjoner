import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/questions/InfoContainer.dart';

import '../registers/InfoContainerRegister.dart';
import '../registers/Register.dart';


class InfoGame extends Game{

  ///Makes an instance of the info game.
  ///[gameName] the name of the game.
  ///[shortDescription] the short description of the game.
  InfoGame({required super.gameName, required super.shortDescription});

  InfoContainerRegister _infoContainerRegister = InfoContainerRegister();

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    _infoContainerRegister.addInfoContainer(
        InfoContainer(containerId: "1", title: "pepe", description: "From DB"));
    _infoContainerRegister.addInfoContainer(InfoContainer(containerId: "2", title: "LUL", description: "slap"));
    //map.addAll({"contents" : _infoContainerRegister.getRegisterAsMap(
    return map;
  }

  @override
  InfoContainerRegister getGameRegister() {
    return _infoContainerRegister;
  }
}