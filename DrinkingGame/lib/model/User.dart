import 'package:drinkinggame/model/StoreableItem.dart';

///represents the details of a logged in user.
class User extends DatabaseItem{

  ///Makes an instance of user.
  ///[username] the username.
  User({required String username}) : this._username = username;

  String _username;

  @override
  String getItemId() {
    return _username;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "username" : _username
    };
  }

}