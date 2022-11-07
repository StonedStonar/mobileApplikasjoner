



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/games/GameType.dart';
import 'package:drinkinggame/model/games/InfoGame.dart';
import 'package:drinkinggame/services/APIPath.dart';

import '../model/questions/InfoContainer.dart';
import '../model/registers/InfoContainerRegister.dart';
import '../model/StoreableItem.dart';
import 'Database.dart';

class FirestoreDatabase implements Database{

  final String _uId;

  ///Makes an instance eof the firestore database.
  ///[uid] the id of the user.
  FirestoreDatabase({required String uId}) : _uId = uId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> setInfoContainer(InfoContainer infoContainer) async {
    _storeItem(infoContainer, "pepe");
  }

  @override
  Stream<InfoContainerRegister> readInfoContainer() {
    // TODO: implement readInfoContainer
    throw UnimplementedError();
  }

  ///Stores a store able item.
  ///[databaseItem] item to store.
  Future<void> _storeItem(DatabaseItem databaseItem, String path) async{
    final documentReference = _firestore.doc(path);
    Map<String, dynamic> map = databaseItem.toMap();
    await documentReference.set(map);
    if(databaseItem is Game){
      map.addAll({"gameType" : GameTypeIdentifier.getGameType(databaseItem).name});
      List<Map<String, dynamic>> contents = databaseItem.getGameRegister().getRegisterAsMap();
      String contentsPath = APIPath.getGameContents(databaseItem.getItemId());
      final contentReference = _firestore.collection(contentsPath);
      contents.forEach((content) async {await contentReference.add(content);});

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
      if(type == GameType.OPEN){
        ///Todo: Change this later when open game is ready
        return InfoGame(gameName: data["gameName"], shortDescription: data["shortDescription"], rules: []);
      }else{
        return InfoGame(gameName: data["gameName"], shortDescription: data["shortDescription"], rules: []);
      }
    }).toList());
  }

  @override
  Stream<List<DatabaseItem>> getContentsOfGame(String gameId) {
    String path = APIPath.getGameContents(gameId);
    print("Gets contents");
    Query<Map<String, dynamic>> reference = _firestore.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((snap) {

      print("pepe");
      print(snap.data().length);
      return InfoContainer(containerId: "lul", title: "title", description: "description");
    }).toList());
  }
  
}