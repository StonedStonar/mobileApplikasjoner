

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../App.dart';
import '../components/AppBars.dart';
import '../components/InfoGameCard.dart';
import '../model/StoreableItem.dart';
import '../model/questions/InfoContainer.dart';
import '../model/registers/InfoContainerRegister.dart';
import '../model/games/InfoGame.dart';
import '../services/database/Database.dart';

///Represents a info game that is shown.
class InfoGamePage extends ConsumerWidget {

  ///Makes an instance of the game page.
  ///[infoGame] the game.
  InfoGamePage({required this.infoGame});

  Database? database;

  final InfoGame infoGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    database = ref.watch(databaseProvider);
    InfoContainerRegister infoContainerRegister = infoGame.getGameRegister();
    return StreamBuilder<List<DatabaseItem>>(
        stream: database?.getContentsOfGame(infoGame),
        builder: (context, snapshot){
          List<InfoContainer>? containers = snapshot.data?.map((item) => item as InfoContainer).toList();
          List<Widget> cards = [];
          containers?.forEach((item) {
            InfoGameCard card = InfoGameCard(infoContainer: item);
            cards.add(card);
            cards.add(SizedBox(height: 10));
            infoContainerRegister.addInfoContainer(item);
            print(infoContainerRegister.getRegisterItems().length);
          });
          if(cards.isEmpty){
            cards.add(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator()
              ],
            ));
          }
          return Scaffold(
            appBar: makeGameAppBar(context, infoGame),
            body: _makeContent(cards),
          );
        }
    );

  }

  ///Makes the content for the info game page.
  ///[infoCards] is the widgets needed
  Widget _makeContent(List<Widget> infoCards) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: infoCards,
        ),
      ),
    );
  }
}
