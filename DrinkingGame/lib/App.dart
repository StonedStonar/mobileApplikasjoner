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

  final defaultShape = MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))));

  final minButtonSize = MaterialStateProperty.resolveWith((states) => Size(20, 50));

  final textButtonStyle = MaterialStateProperty.resolveWith((states) => TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Authentication auth = ref.watch(authProvider);
    auth.authStateChanges().listen((event) {
      ref.read(databaseProvider.notifier).state =
          event != null ? FirestoreDatabase(uId: event.uid) : null;
    });

    MaterialApp materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drinking Games',
      darkTheme: _makeDarkTheme(),
      theme: _makeLightTheme(),
      themeMode: ref.watch(themeProvider),
      initialRoute: "/landingPage",

      ///Has the named routes of the application
      routes: {
        "/landingPage": (context) => LandingPage(),
        "/profile": (context) => ProfilePage(),
        "/editProfile": (context) => EditProfilePage(),
        "/aboutApp": (context) => AboutApplicationPage(),
        "/displayGame": (context) => GameLandingPage(),
      },
    );
    return materialApp;
  }

  ///Makes the light theme
  ///Returns the light theme
  ThemeData _makeLightTheme() {
    return ThemeData(
      primarySwatch: generateMaterialColor(color: const Color(0xFF000434)),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: minButtonSize,
          textStyle: textButtonStyle,
          shape: defaultShape,
        ),
      ),

    );
  }

  ///Makes the dark theme
  ///Returns the dark theme
  ThemeData _makeDarkTheme() {
    Color darkTextColor = Color(0xFFFFF4FF);
    Color darkTextButton = Color(0xFF0E0F1E);
    Color ligtherDarkBlue = Color(0xFF9EA5FF);
    Color darkBaseColor = Color(0xFF000426);
    MaterialColor darkMode = generateMaterialColor(color: darkBaseColor);
    TextStyle darkTextStyle = TextStyle(color: darkTextColor);
    return ThemeData(
      dialogTheme: DialogTheme(
          backgroundColor: darkMode.shade400,
          contentTextStyle: darkTextStyle,
          titleTextStyle: TextStyle(
            color: darkTextColor,
            fontWeight: FontWeight.bold,
          )),
      popupMenuTheme: PopupMenuThemeData(
        color: darkMode.shade400,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: darkTextColor, fontSize: 20, fontWeight: FontWeight.bold),
        hintStyle: darkTextStyle,
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: darkTextColor)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: darkTextColor)),
      ),
      cardColor: darkMode.shade300,
      primarySwatch: darkMode,
      scaffoldBackgroundColor: darkMode.shade900,
      appBarTheme: AppBarTheme(
          shadowColor: darkMode.shade500,
          titleTextStyle:
              TextStyle(color: darkTextColor, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(
            color: darkTextColor,
          )),
      textTheme: TextTheme(
        bodyText1: darkTextStyle,
        bodyText2: darkTextStyle,
        subtitle1: darkTextStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.resolveWith((states) => darkTextButton),
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => ligtherDarkBlue),
          minimumSize: minButtonSize,
          textStyle: textButtonStyle,
          shape: defaultShape,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.resolveWith((states) => darkTextColor),
      )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkMode.shade200,
      ),
    );
  }
}
