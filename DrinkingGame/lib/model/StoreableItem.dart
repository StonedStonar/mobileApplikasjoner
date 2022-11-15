import 'package:drinkinggame/model/questions/InfoContainer.dart';

///Represents an item that can be in a database.
abstract class DatabaseItem{

  ///Gets the id of the storeable.
  ///Returns the id.
  String getItemId();

  ///Makes the storeable item into a map.
  ///Returns the item as a map.
  Map<String, dynamic> toMap();
}