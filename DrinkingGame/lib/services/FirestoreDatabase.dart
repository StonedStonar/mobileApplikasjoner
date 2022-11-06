

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkinggame/model/InfoContainer.dart';

import 'package:drinkinggame/model/InfoContainerRegister.dart';
import 'package:drinkinggame/model/StoreableItem.dart';

import 'APIPath.dart';
import 'Database.dart';

class FirestoreDatabase implements Database{

  final String _uId;

  ///Makes an instance eof the firestore database.
  ///[uid] the id of the user.
  FirestoreDatabase({required String uId}) : _uId = uId;


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
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(databaseItem.toMap());
  }
  
}