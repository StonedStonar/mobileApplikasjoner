import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/CustomText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/Rule.dart';
import '../../model/games/Game.dart';
import '../../model/games/InfoGame.dart';

class DescriptionPage extends StatelessWidget {

  DescriptionPage({required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeMenuAppBar(context, "Description"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
              _descriptionContent(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _descriptionContent(BuildContext context) {
    return [
          _about(),
          SizedBox(height: 10),
          _description()
      ];
  }

  Widget _about() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeadLineText("About ${game.getGameName()}", 30, FontWeight.w600),
        buildHeadLineText("Rules", 20, FontWeight.w500),
        ListView(
          shrinkWrap: true,
          children: [
            ///rules
          ],
        )
      ],
    );
  }

  Widget _description() {
    return Column(
      children: [
        buildHeadLineText("Description", 25, FontWeight.w500),
        buildHeadLineText(game.getLongDescription(), 15, FontWeight.w400)
      ],
    );
  }
}