///Represents a class that holds path for things.
class APIPath{

  ///Gets the path of a game
  ///Returns the game path.
  static String getGamePath(String gameName) => "games/$gameName";

  ///Path to the contets of the game.
  ///Returns the path to the contents.
  static String getGameContents(String gameName) => "${getGamePath(gameName)}/contents";

  ///Gets the games path.
  ///Returns the games path
  static String getGamesPath() => "games";

  ///Makes a custom game.
  ///[gameName] the name of the game.
  ///[uId] the id of the player.
  static String getCustomGamePath(String gameName, String uId) => "users/$uId/${getGamePath(gameName)}";

  ///Gets path of all the info game of the user.
  ///[gameName] the name of the info game.
  static String getInfoContainersOfInfoGame(String gameName) => "games/$gameName/infoContainers";
}