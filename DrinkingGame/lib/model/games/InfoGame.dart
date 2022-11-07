import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/questions/InfoContainer.dart';

import '../registers/InfoContainerRegister.dart';
import '../registers/Register.dart';


class InfoGame extends Game{

  ///Makes an instance of the info game.
  ///[rules] the rules of the game.
  ///[gameName] the name of the game.
  ///[shortDescription] the short description of the game.
  InfoGame({required super.rules, required super.gameName, required super.shortDescription});

  InfoContainerRegister _infoContainerRegister = InfoContainerRegister();

  ///Gets the info game register.
  ///Returns the info game register.
  InfoContainerRegister getInfoContainerRegister(){
    return _infoContainerRegister;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    _infoContainerRegister.addInfoContainer(
        InfoContainer(containerId: "1", title: "pepe", description: "From DB"));
    //map.addAll({"contents" : _infoContainerRegister.getRegisterAsMap(
    return map;
  }

  @override
  Register getGameRegister() {
    return _infoContainerRegister;
  }
}