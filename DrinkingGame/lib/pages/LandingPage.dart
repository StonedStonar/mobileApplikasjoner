import 'package:drinkinggame/pages/GameSelectionPage.dart';
import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/pages/GameSelectionPage.dart';
import 'package:drinkinggame/pages/gamePages/neverHaveIEver/OpenQuestionDisplayPage.dart';
import 'package:drinkinggame/pages/gamePages/neverHaveIEver/OpenQuestionPage.dart';
import 'package:drinkinggame/pages/login/LoginPage.dart';
import 'package:drinkinggame/pages/mainMenuPages/AboutApplicationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/AuthProvider.dart';
import '../services/auth/Authentication.dart';
import 'mainMenuPages/ProfilePage.dart';


///Is the first page that the user gets put into. Changes based on if the user is logged in or not.
class LandingPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Authentication authentication = ref.watch(authProvider);
    return StreamBuilder<User?>(
        stream: authentication.authStateChanges(),
        builder: (context, snapshot) {
          Widget? widgetToShow = const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              widgetToShow = LoginPage();
            } else {
              widgetToShow = GameSelectionPage();
            }
          }
          return widgetToShow;
        });
  }
}
