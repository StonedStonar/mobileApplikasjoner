import 'package:flutter/widgets.dart';

import 'Authentication.dart';

class AuthProvider extends InheritedWidget {

  final Authentication basicAuthentication;

  Widget childTwo;

  AuthProvider({Key? key, required super.child, required this.basicAuthentication, required this.childTwo}) : super(key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  ///Does magic for the fairy.
  static Authentication of(BuildContext context){
    AuthProvider? authProvider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    if(authProvider == null){
      throw Exception();
    }
    return authProvider.basicAuthentication;

  }

}