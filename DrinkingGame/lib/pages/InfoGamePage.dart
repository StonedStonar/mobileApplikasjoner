

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../App.dart';
import '../components/AppBars.dart';
import '../components/InfoGameCard.dart';
import '../model/questions/InfoContainer.dart';
import '../model/registers/InfoContainerRegister.dart';
import '../model/games/InfoGame.dart';
import '../services/Database.dart';

class InfoGamePage extends ConsumerWidget {
  ///Makes an instance of the game page.
  ///[infoGame] the game.
  InfoGamePage({required this.infoGame});

  Database? database;

  final InfoGame infoGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    database = ref.watch(databaseProvider);
    return Scaffold(
      appBar: makeGameAppBar(context, infoGame),
      body: _makeContent(),
    );
  }

  Widget _makeContent() {
    InfoContainerRegister register = infoGame.getInfoContainerRegister();
    database?.getContentsOfGame(infoGame.getItemId());
    register.addInfoContainer(InfoContainer(
        containerId: "2",
        title: "`1 - Peppa",
        description:
            "Peppa is a pig in a childish that scars the viewers in disturbing ways."));
    register.addInfoContainer(InfoContainer(containerId: "1", title: "Pepe", description: "meme"));


    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: getInfoCards(),
        ),
      ),
    );
  }

  ///Makes the info cards.
  ///Returns the info cards.
  List<Widget> getInfoCards(){
    InfoContainerRegister register = infoGame.getInfoContainerRegister();
    List<Widget> cards = [];
    register.getRegisterItems().forEach((infoContainer) {
      cards.add(InfoGameCard(infoContainer: infoContainer));
      cards.add(SizedBox(height: 10,));
    });
    return cards;
  }
}
