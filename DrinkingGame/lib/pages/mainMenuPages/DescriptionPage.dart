import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/CustomText.dart';
import 'package:drinkinggame/model/registers/RuleRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/Rule.dart';
import '../../model/games/Game.dart';
import '../../model/games/InfoGame.dart';
import '../../providers/DatabaseProvider.dart';


///Page for displaying information about a game.
class DescriptionPage extends ConsumerWidget {

  ///Makes an instance of the Description page
  ///[game] the game
  DescriptionPage({required this.game});

  ///The game to display information from.
  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> widgets = _descriptionContent(context);
    if(game.getRules().hasRules()){
      game.getRules().updateStream();
    }
    return Scaffold(
      appBar: makeMenuAppBar(context, "Description"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        ),
      ),
    );
  }

  ///Makes the description contents.
  ///[context] the build context
  ///Returns a list of widgets
  List<Widget> _descriptionContent(BuildContext context) {
    return [
          _about(),
          SizedBox(height: 15),
          _description()
      ];
  }


  ///Makes the bout segment
  ///Returns the about widget
  Widget _about() {
    List<Widget> ruleWidget = [];
    game.getRules().getRegisterItems().forEach((rule) {
      ruleWidget.add(makeRuleWidget(rule));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "About ${game.getGameName()}", fontSize: 30, fontWeight: FontWeight.w600),
        SizedBox(height: 15,),
        CustomText(text: "Rules", fontSize: 25, fontWeight: FontWeight.w500),
        SizedBox(height: 10,),
        ListView(
        shrinkWrap: true,
        children: ruleWidget,
        ),
      ],
    );
  }

  ///Makes a rule widget
  ///[rule] the rule to make
  ///Returns the rule widget
  Widget makeRuleWidget(Rule rule) {
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