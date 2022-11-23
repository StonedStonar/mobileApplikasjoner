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
          padding: const EdgeInsets.all(15.0),
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
          SizedBox(height: 15),
          _description()
      ];
  }

  Widget _about() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "About ${game.getGameName()}", fontSize: 30, fontWeight: FontWeight.w600),
        SizedBox(height: 15,),
        CustomText(text: "Rules", fontSize: 25, fontWeight: FontWeight.w500),
        SizedBox(height: 10,),
        StreamBuilder<List<Rule>>(
            stream: game.getRules().getStream(),
            builder: (context, snapshot) {
              Widget widget = Text("No rules");
              if(snapshot.hasData){
                List<Widget> children = [];
                snapshot.data?.forEach((rule) {
                  children.add(ruleWidget(rule) );
                });
                widget = ListView(
                  shrinkWrap: true,
                  children: children,
                );
              }
              return widget;
            },
        )

      ],
    );
  }

  Widget ruleWidget(Rule rule) {
     return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Row(
           children: [
             Icon(CupertinoIcons.circle_fill,
               size: 5,),
             SizedBox(width: 10,),
             Text(rule.getRuleText()),
           ],
         ),
         Row(
           children: [
             Icon(CupertinoIcons.arrow_right),
             SizedBox(width: 10,),
             Text(rule.getPunishment())
           ],
         )
       ],
     );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Description", fontSize: 25, fontWeight: FontWeight.w500),
        SizedBox(height: 10,),
        Text(game.getLongDescription())
      ],
    );
  }
}