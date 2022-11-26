import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/Rule.dart';
import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/enums/TruthOrDare.dart';
import 'package:drinkinggame/model/games/InfoGame.dart';
import 'package:drinkinggame/model/questions/InfoContainer.dart';
import 'package:drinkinggame/model/questions/QuestionType.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/games/Game.dart';
import '../pages/gamePages/GameLandingPage.dart';
import '../providers/DatabaseProvider.dart';

class CustomGameAlert extends ConsumerStatefulWidget {
  CustomGameAlert({required this.game,super.key});

  Game game;


  @override
  ConsumerState<CustomGameAlert> createState() => _CustomGameAlertState();
}

class _CustomGameAlertState extends ConsumerState<CustomGameAlert> {

  TextEditingController _titleController = TextEditingController();

  TextEditingController _idController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();


  bool _rule = false;

  bool _isTruth = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _makeContentsOfColumn(context),
    );
  }

  ///Makes the fields for the alert.
  ///[context] the build context
  ///Returns the list of widgets.
  List<Widget> _makeContentsOfColumn(BuildContext context){
    List<Widget> widgets = [];
    VoidCallback onPressed = saveItem;
    if(!_rule){
      switch(widget.game.runtimeType){
        case InfoGame:
          widgets = makeInfoContainer();
          break;
        case TruthOrDare:

          break;
        default:

          break;
      }
    }else{
      widgets = makeRuleContents();
    }
    Checkbox box = Checkbox(value: _rule, onChanged: (bool? value){
      _rule = value!;
      setState(() {

      });
    });
    widgets.add(Row(children: [Text("Is rule"), box]));
    widgets.add(TextButton(
        onPressed: () => onPressed(),
        child: Text("Add")),);
    return widgets;
  }

  ///Saves the item to firebase.
  void saveItem(){
    DatabaseItem? databaseItem = null;
    String title = _titleController.text;
    String id = _idController.text;
    String desc = _descriptionController.text;
    if(!_rule){
      switch(widget.game.runtimeType){
        case InfoGame:
          databaseItem = InfoContainer(containerId: id, title: title, description: desc);
          break;
        case TruthOrDare:
          Player player = Player(playerID: 1, playerName: "bjarne");
          databaseItem = TruthOrDareQuestion(questionText: title, questionId: int.parse(id), madeBy: player, truthOrDare: _isTruth ? TruthOrDare.TRUTH : TruthOrDare.DARE);
          break;
        default:

          break;
      }
      ref?.watch(databaseProvider)?.setItemForGame(widget.game, databaseItem!);
    }else{
      ref?.watch(databaseProvider)?.setRuleForGame(widget.game, Rule(ruleId: int.parse(_idController.text), ruleText: _titleController.text, punishment: _descriptionController.text));
    }
    Navigator.of(context).pop(false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GameLandingPage()));
  }

  ///Makes the rule contents
  ///Returns the list with widgets
  List<Widget> makeRuleContents(){
    List<Widget> widgets = [];
    widgets.add(Text("Make rule"));
    widgets.add(makeTextField(_titleController, "Rule text"));
    widgets.add(makeTextField(_idController, "Rule id"));
    widgets.add(makeTextField(_descriptionController, "Punishment"));
    return widgets;
  }

  ///Makes the contents of open question
  ///Returns the list with widgets
  List<Widget> makeOpenQuestionContents(){
    List<Widget> widgets = [];
    widgets.add(Text("Open question"));
    widgets.add(makeTextField(_titleController, "Title"));
    widgets.add(makeTextField(_idController, "Question id"));
    widgets.add(makeTextField(_descriptionController, "Description"));
    return widgets;
  }

  ///Makes the conents for info container
  ///Returns the list with widgets
  List<Widget> makeInfoContainer(){
    List<Widget> widgets = [];
    widgets.add(Text("Info container"));
    widgets.add(makeTextField(_titleController, "Title"));
    widgets.add(makeTextField(_idController, "Info container id"));
    widgets.add(makeTextField(_descriptionController, "Description"));
    return widgets;
  }

  ///Makes fields for player questions.
  ///Returns the widgets.
  List<Widget> makePlayerQuestions(){
    List<Widget> widgets = [];
    widgets.add(Text("Truth or dare"));
    widgets.add(Checkbox(value: _isTruth, onChanged: (value){
      _isTruth = !_isTruth;
      setState(() {});
    }));
    widgets.add(makeTextField(_titleController, "Title"));
    widgets.add(makeTextField(_idController, "Id"));
    widgets.add(makeTextField(_descriptionController, "Truth or dare text"));
    return widgets;
  }

  ///Makes an textfield.
  ///[controller] the controller of textfield
  ///[textFieldLabel] the label of the text field.
  ///REturns the textfield
  TextField makeTextField(TextEditingController controller, String textFieldLabel ){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: textFieldLabel,
      ),
    );
  }
}
