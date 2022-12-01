



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkinggame/model/games/Game.dart';
import 'package:drinkinggame/model/enums/GameType.dart';
import 'package:drinkinggame/model/games/InfoGame.dart';
import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/registers/GameRegister.dart';
import 'package:drinkinggame/model/registers/RuleRegister.dart';

import '../../model/Rule.dart';
import '../../model/questions/InfoContainer.dart';
import '../../model/StoreableItem.dart';
import '../../model/registers/Register.dart';
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

    List<Map<String, dynamic>> gameRules = game.getRules().getRulesAsMap();
    String rulesPath = APIPath.getGameRules(game.getItemId());
    final rulesReference = _firestore.collection(rulesPath);
    gameRules.forEach((rule) async {await rulesReference.add(rule);});
  }

  @override
  Future<void> setCustomGame(Game game) async {
    _storeGame(game);
  }

  @override
  Future<void> getGames(GameRegister gameRegister) async {
    String path = APIPath.getGamesPath();
    QuerySnapshot<Map<String, dynamic>> reference = await _firestore.collection(path).get();
    reference.docs.forEach((map) {
      String type = map["gameType"];
      String gameName = map["gameName"];
      String shortD = map["shortDescription"];
      String longD = map["longDescription"];
      late Game game;
      if(type == GameType.TRUTHORDARE.name){
        game = StatementGame(gameName: gameName, shortDescription: shortD, longDescription: longD);
      }else if(type == GameType.OPEN.name){
        game = OpenQuestionGame(gameName: gameName, shortDescription: shortD, longDescription: longD, statementName: map["statementName"]);
      }else if(type == GameType.INFO.name){
        game = InfoGame(gameName: gameName, shortDescription: shortD, longDescription: longD, overviewTitle: map["overviewTitle"]);
      }
      try{
        gameRegister.addGame(game);
      }catch(e){

      }
    });
    gameRegister.updateStream();
  }

  @override
  Future<void> setItemForGame(Game game, DatabaseItem databaseItem) async {
    String path = APIPath.getGameContents(game.getGameName());
    await _firestore.collection(path).add(databaseItem.toMap());
  }
  @override
  Future<void> getContentsOfGame(Game game) async {
    String questionPath = APIPath.getGameContents(game.getItemId());
    QuerySnapshot<Map<String, dynamic>> reference = await _firestore.collection(questionPath).get();
    Register gameRegister = game.getGameRegister();
    gameRegister.getRegisterItems().clear();
    reference.docs.forEach((map) {
      if (game is InfoGame) {
        game.getGameRegister().addInfoContainer(
            InfoContainer.fromMap(map: map.data()));
      } else if (game is OpenQuestionGame){
        game.getGameRegister().add(OpenQuestion.fromMap(map.data()));
      }
    });
    gameRegister.updateStream();
  }

  @override
  Future<void> updateGame(Game game) async {
    String rulePath = APIPath.getGamePath(game.getGameName());
    DocumentSnapshot<Map<String, dynamic>> ruleReference = await _firestore.doc(rulePath).get();
    game.updateAllDetails(ruleReference["shortDescription"], ruleReference["longDescription"]);
    game.getRules().getRegisterItems().clear();
    game.getGameRegister().getRegisterItems().clear();
    getContentsOfGame(game);
    getRulesForGame(game);
  }

  @override
  Future<void> setRuleForGame(Game game, Rule rule) async {
    String rulePath = APIPath.getGameRules(game.getGameName());
    await _firestore.collection(rulePath).add(rule.toMap());
  }

  @override
  Future<void> getRulesForGame(Game game) async {
    String rulePath = APIPath.getGameRules(game.getGameName());
    QuerySnapshot<Map<String, dynamic>> ruleReference = await _firestore.collection(rulePath).get();
    RuleRegister ruleRegister = game.getRules();
    ruleRegister.getRegisterItems().clear();
    ruleReference.docs.forEach((map) {
      ruleRegister.addRule(Rule.fromMap(map: map.data()));
    });
    ruleRegister.updateStream();
  }
}