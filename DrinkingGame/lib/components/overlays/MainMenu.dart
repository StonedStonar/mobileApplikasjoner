
import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/pages/mainMenuPages/AboutApplicationPage.dart';
import 'package:drinkinggame/pages/GameSelectionPage.dart';
import 'package:drinkinggame/pages/LandingPage.dart';
import 'package:drinkinggame/pages/mainMenuPages/ProfilePage.dart';
import 'package:drinkinggame/pages/mainMenuPages/SettingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/AuthProvider.dart';
import '../../services/auth/Authentication.dart';
import '../Dialogs.dart';
import '../buttons/MenuButton.dart';
import 'SideMenu.dart';

///Represents a main menu.
class MainMenu extends ConsumerWidget {

  Authentication? _authentication;

  ///Makes an instance of the main menu.
  MainMenu({super.key});

  ///Builds the content of the main menu.
  ///[context] the build context
  Widget buildContent(BuildContext context){
    return Column(
      children: [
        MenuButton(buttonText: "Games", icon: Icons.gamepad, onPressed: () => _openPage("/landingPage", context)),
        MenuButton(buttonText: "Settings", icon: Icons.settings, onPressed: () => _openPage("/settings", context)),
        MenuButton(buttonText: "Profile", icon: Icons.person, onPressed: () => _openPage("/profile", context)),
        MenuButton(buttonText: "About app", icon: Icons.info, onPressed: () => _openPage("/aboutApp", context)),
        MenuButton(buttonText: "Logout", icon: Icons.logout, onPressed: () => _confirmSignOut(context)),
      ],
    );
  }

  ///Opens a new page.
  ///[widget] widget to open on a new page.
  ///[context] the build context.
  void _openPage(String nameOfPage, BuildContext context){
    Navigator.pushReplacementNamed(context, nameOfPage);
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
      await _authentication?.signOut();
      _openPage("/landingPage", context);
    }on Exception catch(e){
      showExceptionAlertDialog(context, title: "Could not sign out", exception: e);
    }

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _authentication = ref.watch(authProvider);
    return SideMenu(child: buildContent(context));
  }
}