

import 'package:drinkinggame/model/InfoContainer.dart';
import 'package:drinkinggame/model/InfoContainerRegister.dart';

abstract class Database{


  ///Creates a new infoContainer or adds it
  ///[infoContainer] infoContainer to add.
  Future<void> setInfoContainer(InfoContainer infoContainer);

  ///Reads all the info containers form the database.
  ///Returns a stream with jobs.
  Stream<InfoContainerRegister> readInfoContainer();
}