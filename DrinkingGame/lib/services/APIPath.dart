///Represents a class that holds path for things.
class APIPath{

  ///Gets the path of a info game
  ///Returns the job path.
  static String getGamePath(String gameName) => "games/$gameName";

  ///Gets path of all the info game of the user.
  ///[gameName] the name of the info game.
  static String getInfoContainersOfInfoGame(String gameName) => "games/$gameName/infoContainers";
}