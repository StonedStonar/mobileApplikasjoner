import 'package:drinkinggame/components/CustomText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/Rule.dart';
import '../../model/games/Game.dart';
import '../../model/games/InfoGame.dart';

class DescriptionPage extends StatelessWidget {

  DescriptionPage({required this.game});

  final InfoGame game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
              _descriptionContent(),
          ),
        ),
      ),
    );
  }

  List<Widget> _descriptionContent() {
    return [
          _ExitPageButton(),
          SizedBox(height: 10),
          _about(),
          SizedBox(height: 10),
          _description()
      ];
  }

  Widget _ExitPageButton() {
    return IconButton(onPressed: () {}, icon: Icon(
      CupertinoIcons.return_icon,
    ));
  }

  Widget _about() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "About ${game.getGameName()}", fontSize: 30, fontWeight: FontWeight.w600),
        CustomText(text: "Rules", fontSize: 20, fontWeight: FontWeight.w500),
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
        CustomText(text: "Description", fontSize: 25, fontWeight: FontWeight.w500),
        ///TODO: Infogame should have a long description aswell
        CustomText(text: game.getShortDescription(), fontSize: 15, fontWeight: FontWeight.w400)
      ],
    );
  }
}