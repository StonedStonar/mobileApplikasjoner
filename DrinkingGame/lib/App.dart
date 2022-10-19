import 'package:drinkinggame/pages/GamePage.dart';
import 'package:drinkinggame/services/Authentication.dart';
import 'package:drinkinggame/services/FirebaseAuthenication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/PopUpMenu.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp =  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: const Color(0xFF000434),
        ),
      ),
      home: GamePage(),
    );
    return Provider<Authentication>(
      create: (BuildContext context) => FirebaseAuthentication(),
      child: materialApp,
    );
  }
}