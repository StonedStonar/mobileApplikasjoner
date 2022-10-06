import 'package:drinkinggame/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/Authentication.dart';
import 'HomePage.dart';

class LandingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Provider.of<Authentication>(context, listen: false);
    return StreamBuilder<User?>(
        stream: authentication.authStateChanges(),
        builder: (context, snapshot){
          Widget? widgetToShow = const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
          if(snapshot.connectionState == ConnectionState.active){
            User? user = snapshot.data;
            print("User: $user");
            if(user == null){
              widgetToShow = LoginPage();
            }else{
              widgetToShow = HomePage();
            }
          }
          return widgetToShow;
        });
  }

}