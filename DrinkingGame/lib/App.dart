


import 'package:drinkinggame/pages/LandingPage.dart';
import 'package:drinkinggame/services/Authentication.dart';
import 'package:drinkinggame/services/Database.dart';
import 'package:drinkinggame/services/FirebaseAuthenication.dart';
import 'package:drinkinggame/services/FirestoreDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_color_generator/material_color_generator.dart';

final authProvider = StateProvider<Authentication>((ref) {
  return FirebaseAuthentication();
});

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);


final databaseProvider = StateProvider<Database?>((ref){
  return null;
});


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
      home: LandingPage(),
      );
    return materialApp;
  }
}
