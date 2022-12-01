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

    ThemeData lightTheme = new ThemeData(
      primarySwatch: generateMaterialColor(color: const Color(0xFF000434)),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.yellow,
        ),
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.yellow),
          bodyText2: TextStyle(color: Colors.red),
      ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
          ),
        ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.orange),
        )
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.green,
      )
    );

    MaterialColor darkMode = generateMaterialColor(color: const Color(0xFF000434));
    ThemeData darkTheme = ThemeData(
        primarySwatch: generateMaterialColor(color: const Color(0xFF000434)),
        scaffoldBackgroundColor: darkMode.shade900,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.yellow),
          bodyText2: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
            backgroundColor: MaterialStateProperty.resolveWith((states) => darkMode.shade400),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white60),
            )
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,
        )
    );

    MaterialApp materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drinking Games',
      darkTheme: darkTheme,
      theme: lightTheme,
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
