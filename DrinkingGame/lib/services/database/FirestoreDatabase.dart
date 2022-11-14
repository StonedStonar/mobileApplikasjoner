



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/games/GameType.dart';
import 'package:drinkinggame/model/games/InfoGame.dart';

import '../../model/questions/InfoContainer.dart';
import '../../model/StoreableItem.dart';
import 'APIPath.dart';
import 'Database.dart';

class FirestoreDatabase implements Database{

  final String _uId;

  ///Makes an instance eof the firestore database.
  ///[uid] the id of the user.
  FirestoreDatabase({required String uId}) : _uId = uId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Stores a store able item.
  ///[databaseItem] item to store.
  Future<void> _storeItem(DatabaseItem databaseItem, String path) async{
    final documentReference = _firestore.doc(path);
    Map<String, dynamic> map = databaseItem.toMap();
    await documentReference.set(map);
  }

  ///Stores a game in the database.
  ///[game] the game to store.
  ///[path] the path to the game.
  Future<void> _storeGame(Game game) async{
    String path = APIPath.getGamePath(game.getGameName());///APIPath.getCustomGamePath(game.getGameName(), _uId); <- for custom games
    final documentReference = _firestore.doc(path);
    Map<String, dynamic> map = game.toMap();
    map.addAll({"gameType" : GameTypeIdentifier.getGameType(game).name});

    await documentReference.set(map);
    List<Map<String, dynamic>> gameContents = game.getGameRegister().getRegisterAsMap();
    String contentsPath = APIPath.getGameContents(game.getItemId());
    final contentReference = _firestore.collection(contentsPath);
    gameContents.forEach((content) async {await contentReference.add(content);});

    List<Map<String, dynamic>> gameRules = game.getRulesAsMap();
    String rulesPath = APIPath.getGameRules(game.getItemId());
    final rulesReference = _firestore.collection(rulesPath);
    gameRules.forEach((rule) async {await rulesReference.add(rule);});

  }

  @override
  Future<void> setCustomGame(Game game) async {
    _storeGame(game);
  }

  @override
  Stream<List<Game>> getGames() {
    String path = APIPath.getGamesPath();
    Query<Map<String, dynamic>> reference = _firestore.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((snap) {
      final data = snap.data();
      String type = data["gameType"];
      Game game = InfoGame(gameName: data["gameName"], shortDescription: data["shortDescription"], rules: []);
      if(type == GameType.OPEN){
        ///Todo: Change this later when open game is ready
        game = InfoGame(gameName: data["gameName"], shortDescription: data["shortDescription"], rules: []);
      }
      return game;

    }).toList());
  }

  @override
  Stream<List<DatabaseItem>> getContentsOfGame(Game game) {
    String path = APIPath.getGameContents(game.getItemId());
    GameType gameType = GameTypeIdentifier.getGameType(game);
    Query<Map<String, dynamic>> reference = _firestore.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((snap) {
      final data = snap.data();
      DatabaseItem databaseItem = InfoContainer(containerId: data["title"], title: data["title"], description: data["description"]);
      if(gameType == GameType.OPEN){

      }else if(gameType == GameType.PLAYER){

      }
      return databaseItem;
    }).toList());
  }

  @override
  Future<void> setItemForGame(Game game, DatabaseItem databaseItem) async {
    String path = APIPath.getGameContents(game.getGameName());
    await _firestore.collection(path).add(databaseItem.toMap());
  }
}