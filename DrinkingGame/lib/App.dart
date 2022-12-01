import 'package:drinkinggame/pages/LandingPage.dart';
import 'package:drinkinggame/pages/gamePages/GameLandingPage.dart';
import 'package:drinkinggame/pages/mainMenuPages/AboutApplicationPage.dart';
import 'package:drinkinggame/pages/mainMenuPages/ProfilePage.dart';
import 'package:drinkinggame/providers/AuthProvider.dart';
import 'package:drinkinggame/providers/DatabaseProvider.dart';
import 'package:drinkinggame/providers/ThemeProvider.dart';
import 'package:drinkinggame/services/auth/Authentication.dart';
import 'package:drinkinggame/services/database/FirestoreDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_color_generator/material_color_generator.dart';

import 'pages/EditProfilePage.dart';

///Represents the main class of the app.
class App extends ConsumerWidget {

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Authentication auth = ref.watch(authProvider);
    auth.authStateChanges().listen((event) {
      ref.read(databaseProvider.notifier).state = event != null ? FirestoreDatabase(uId: event.uid) : null;
    });

    MaterialApp materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drinking Games',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        ///Used a library to generate the material color since it was a pain.
        primarySwatch: generateMaterialColor(color: const Color(0xFF000434)),
      ),
      themeMode: ref.watch(themeProvider),
      initialRoute: "/landingPage",
      routes: {
        "/landingPage" : (context) => LandingPage(),
        "/profile" : (context) => ProfilePage(),
        "/editProfile" : (context) => EditProfilePage(),
        "/aboutApp" : (context) => AboutApplicationPage(),
        "/displayGame" : (context) =>  GameLandingPage(),
      },
      );
    return materialApp;
  }
}
