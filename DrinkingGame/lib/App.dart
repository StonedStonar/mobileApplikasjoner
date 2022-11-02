import 'package:drinkinggame/pages/AboutApplicationPage.dart';
import 'package:drinkinggame/services/Authentication.dart';
import 'package:drinkinggame/services/FirebaseAuthenication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_color_generator/material_color_generator.dart';


final authProvider = StateProvider<Authentication>((ref) {
  return FirebaseAuthentication();
});

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

///Represents the main class of the app.
class MyApp extends ConsumerWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MaterialApp materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drinking Games',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        ///Used a library to generate the material color since it was a pain.
        primarySwatch: generateMaterialColor(color: const Color(0xFF000434)),
      ),
      themeMode: ref.watch(themeProvider),
      home: const AboutApplicationPage(),
      );
    return materialApp;
  }
}
