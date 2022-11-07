import '../StoreableItem.dart';

///Represents a general register.
abstract class Register {

  ///Gets the register as a list with maps.
  ///Return all the items as maps.
  List<Map<String, dynamic>> getRegisterAsMap(){
    List<Map<String, dynamic>> items = [];
    getRegisterItems().forEach((container) {items.add(container.toMap());});
    return items;
  }

  ///Gets all the items from that register.
  ///Returns a list with all the items.
  List<DatabaseItem> getRegisterItems();
}