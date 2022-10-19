import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/pages/GamePage.dart';
import 'package:drinkinggame/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../services/Authentication.dart';

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
            print("User: $user");
            if (user == null) {
              widgetToShow = LoginPage();
            } else {
              widgetToShow = GamePage();
            }
          }
          return widgetToShow;
        });
  }
}
