import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/questions/InfoContainer.dart';

import '../registers/InfoContainerRegister.dart';

///Represents an information game that shows its contents as containers
class InfoGame extends Game{

  ///Makes an instance of the info game.
  ///[gameName] the name of the game.
  ///[shortDescription] the short description of the game.
  ///[longDescription] the long description of the game describing it more in detail.
  ///[overviewTitle] the title of the info game overview.
  InfoGame({required super.gameName, required super.shortDescription, required super.longDescription, required String overviewTitle}) : _overviewTitle = overviewTitle;

  InfoContainerRegister _infoContainerRegister = InfoContainerRegister();

  String _overviewTitle;

  ///Gets the overview title
  ///Returns the overview title
  String getOverviewTitle(){
    return _overviewTitle;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = getGameDetails();
    map["overviewTitle"] = _overviewTitle;
    return map;
  }

  @override
  InfoContainerRegister getGameRegister() {
    return _infoContainerRegister;
  }
}