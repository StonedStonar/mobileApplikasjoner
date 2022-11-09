



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/games/GameType.dart';
import 'package:drinkinggame/model/games/InfoGame.dart';

import '../../model/questions/InfoContainer.dart';
import '../../model/registers/InfoContainerRegister.dart';
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
    if(databaseItem is Game){
      map.addAll({"gameType" : GameTypeIdentifier.getGameType(databaseItem).name});
      await documentReference.set(map);
      List<Map<String, dynamic>> contents = databaseItem.getGameRegister().getRegisterAsMap();
      String contentsPath = APIPath.getGameContents(databaseItem.getItemId());
      final contentReference = _firestore.collection(contentsPath);
      contents.forEach((content) async {await contentReference.add(content);});
    }else{
      await documentReference.set(map);
    }
  }

  @override
  Future<void> setCustomGame(Game game) async {
    ///Todo: Change this back later
    String path = APIPath.getGamePath(game.getGameName());///APIPath.getCustomGamePath(game.getGameName(), _uId);
    _storeItem(game, path);
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
  
}