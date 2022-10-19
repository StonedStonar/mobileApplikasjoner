import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/Authentication.dart';
import '../Dialogs.dart';
import '../buttons/MenuButton.dart';
import 'SideMenu.dart';

///Represents a main menu.
class MainMenu extends StatelessWidget {

  ///Makes an instance of the main menu.
  MainMenu({super.key});

  ///Builds the content of the main menu.
  ///[context] the build context
  Widget buildContent(BuildContext context){
    return Column(
      children: [
        MenuButton(buttonText: "Games", icon: Icons.gamepad, onPressed: (){}),
        MenuButton(buttonText: "Settings", icon: Icons.settings, onPressed: (){}),
        MenuButton(buttonText: "Profile", icon: Icons.person, onPressed: (){}),
        MenuButton(buttonText: "About app", icon: Icons.info, onPressed: (){}),
        MenuButton(buttonText: "Logout", icon: Icons.logout, onPressed: () => _confirmSignOut(context)),
      ],
    );
  }


  ///Confirms the sign out process.
  ///[context] is the buildcontext.
  Future<void> _confirmSignOut(BuildContext context) async{
    final didSignOut = await showAlertDialog(context,
      title: "Logout",
      content: "Are you sure you want to log out?",
      defaultActionText: "Logout",
      cancelActionText: "Cancel",
    );
    if(didSignOut == true){
      _signOut(context);
    }
  }

  ///Signs the person out of the application.
  Future<void> _signOut(BuildContext context) async{
    try{
      await Provider.of<Authentication>(context, listen: false).signOut();
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(child: buildContent(context));
  }
}