import 'package:drinkinggame/pages/GamePage.dart';
import 'package:drinkinggame/pages/LandingPage.dart';
import 'package:drinkinggame/services/Authentication.dart';
import 'package:drinkinggame/services/FirebaseAuthenication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';

import 'components/PopUpMenu.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        ///Used a library to generate the material color since it was a pain.
        primarySwatch: generateMaterialColor(color: Color(0xFF000434)),
      ),
      home: LandingPage(),
    );
    return Provider<Authentication>(
      create: (BuildContext context) => FirebaseAuthentication(),
      child: materialApp,
    );
  }
}
