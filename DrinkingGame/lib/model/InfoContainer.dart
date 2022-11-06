import 'package:drinkinggame/model/StoreableItem.dart';

///Represents a info container that only holds information about a game.
class InfoContainer extends DatabaseItem{

  ///Makes an instance of info container.
  ///[containerId] is the id of the container.
  ///[title] the title if the container.
  ///[description] the description
  InfoContainer({required String containerId, required String title, required String description}) : _title = title, _description = description, _containerId = containerId;

  String _title;
  String _containerId;
  String _description;

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