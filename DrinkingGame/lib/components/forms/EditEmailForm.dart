import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:flutter/cupertino.dart';

class EditProfile {

  ///TexteditingControllers for getting user input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _editUsernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _editEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController = TextEditingController();

  ///Focusnodes for textfields
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  ///Simplified getters for the user input
  String get _username => _usernameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmationPassword => _confirmationPasswordController.text;

  List<Widget> buildEditUsernameWidget() {
    return [

    ];
  }

  ///Updates the state - rebuilds components
  void _updateState() {

  }
}