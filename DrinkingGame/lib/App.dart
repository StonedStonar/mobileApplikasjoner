import 'package:drinkinggame/pages/LandingPage.dart';
import 'package:drinkinggame/pages/gamePages/GameLandingPage.dart';
import 'package:drinkinggame/pages/mainMenuPages/AboutApplicationPage.dart';
import 'package:drinkinggame/pages/mainMenuPages/ProfilePage.dart';
import 'package:drinkinggame/providers/AuthProvider.dart';
import 'package:drinkinggame/providers/DatabaseProvider.dart';
import 'package:drinkinggame/providers/ThemeProvider.dart';
import 'package:drinkinggame/services/auth/Authentication.dart';
import 'package:drinkinggame/services/database/FirestoreDatabase.dart';
import 'package:flutter/cupertino.dart';
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
      darkTheme: _makeDarkTheme(),
      theme: _makeLightTheme(),
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

  ///Makes the light theme
  ///Returns the light theme
  ThemeData _makeLightTheme(){
    return ThemeData(
      primarySwatch: generateMaterialColor(color: const Color(0xFF000434)),
    );
  }

  ///Makes the dark theme
  ///Returns the dark theme
  ThemeData _makeDarkTheme(){
    Color darkTextColor = Color(0xFFFFF4FF);
    Color darkTextButton = Color(0xFF0E0F1E);
    ///0xFF565FFF
    Color ligtherDarkBlue = Color(0xFF9EA5FF);
    Color darkBaseColor = Color(0xFF000426);
    MaterialColor darkMode = generateMaterialColor(color: darkBaseColor);
    return ThemeData(
        dialogTheme: DialogTheme(
          backgroundColor: darkMode.shade400,
          contentTextStyle: TextStyle(
            color: darkTextColor,
          ),
          titleTextStyle: TextStyle(
            color: darkTextColor,
            fontWeight: FontWeight.bold,
          )
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: darkMode.shade400,
        ),

        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: darkTextColor,
          ),

          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: darkTextColor)
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: darkTextColor)
          ),
        ),
        cardColor: darkMode.shade300,
        primarySwatch: darkMode,
        scaffoldBackgroundColor: darkMode.shade900,
        appBarTheme: AppBarTheme(
            shadowColor: darkMode.shade500,
            titleTextStyle: TextStyle(
                color: darkTextColor,
                fontWeight: FontWeight.bold
            ),
            iconTheme: IconThemeData(
              color: darkTextColor,
            )
        ),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: darkTextColor),
            bodyText2: TextStyle(color: darkTextColor),
            subtitle1: TextStyle(color: darkTextColor)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) => darkTextButton),
            backgroundColor: MaterialStateProperty.resolveWith((states) => ligtherDarkBlue),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) => darkTextColor),
            )
        )
    );
  }
}
