import 'package:drinkinggame/model/StoreableItem.dart';

///Represents a info container that only holds information about a game.
class InfoContainer extends DatabaseItem{

  ///Makes an instance of info container.
  ///[containerId] is the id of the container.
  ///[title] the title if the container.
  ///[description] the description.
  InfoContainer({required String containerId, required String title, required String description}) : _title = title, _description = description, _containerId = containerId;

  ///Makes a InfoContainer from a map.
  ///[map] the map.
  InfoContainer.fromMap({required Map<String, dynamic> map}) : assert(map.length == 3), _title = map["title"], _containerId = map["containerId"], _description = map["description"];

  final String _title;
  final String _containerId;
  final String _description;

  ///Gets the title
  ///Returns the title
  String getTitle(){
    return _title;
  }

  ///Gets the description
  ///Returns the description.
  String getDescription(){
    return _description;
  }

  @override
  String getItemId() {
    return _containerId;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "title": _title,
      "description": _description,
    };
  }
}