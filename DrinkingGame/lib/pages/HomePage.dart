import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/Dialogs.dart';
import '../components/buttons/CustomElevatedButton.dart';
import '../services/Authentication.dart';

class HomePage extends StatelessWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pog"),
        centerTitle: true,
      ),
      body: Center(
        child: CustomElevatedButton(widget: Text("Sign out m8", style: TextStyle(color: Colors.black),), borderRadius: 10, onPressed: () => _confirmSignOut(context), color: Colors.white,),
      ),
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
}