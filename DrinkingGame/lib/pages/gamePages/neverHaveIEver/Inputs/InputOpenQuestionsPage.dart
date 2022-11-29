import 'package:drinkinggame/components/GameInputForm.dart';
import 'package:drinkinggame/components/QuestionInputField.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/CustomText.dart';
import '../../../../components/forms/textfields/TextFields.dart';
import '../../../../model/Player.dart';

class InputOpenQuestionsPage extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {

  InputOpenQuestionsPage({required this. openQuestionRegister,required this.onDone, Key? key}) : super(key: key);


  OpenQuestionRegister openQuestionRegister;

  VoidCallback onDone;


  @override
  ConsumerState<InputOpenQuestionsPage> createState() => _CustomNeverHaveIEverQuestionInputPageState();
}

class _CustomNeverHaveIEverQuestionInputPageState extends ConsumerState<InputOpenQuestionsPage> {

  ///Controller for the textfield
  final TextEditingController _userInputController = TextEditingController();


  ///Getter for input player writes in the textfield
  String get _userInput => _userInputController.text;

  bool _submitted = false;



  ///Local array for the truths and dares the user creates
  ///Used for merging with ALL the questions
  List<OpenQuestion> userQuestions = [];

  int questionId = 1;


  ///Build the page
  @override
  Widget build(BuildContext context) {

    Widget textField = _buildTextFieldWithButton();
    String titleText = "Write in your Never Have I Ever <3 " ;
    Widget widgetToShow = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildContent(GameInputForm(formTitle: titleText, textField: textField)),
      ),
    );

    print(userQuestions.length);
    return widgetToShow;
  }

  List<Widget> _buildContent(GameInputForm gameInputForm) {
    List<Widget> widgets = [];
    userQuestions.forEach((question) => widgets.add(_makeQuestionWidget(question)));
    return [
      gameInputForm,
      CustomText(text: "Never Have I Evah", fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(
        height: 200,
        child: SingleChildScrollView(
          child: Column(
            children: widgets,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: _buildElevatedButton("Play game", ),
          ),

        ],
      )
    ];
  }

  Widget _makeQuestionWidget(OpenQuestion openQuestion){
    //Todo: STyle this you shit
    return Text(openQuestion.getQuestionText());
  }

  ///Builds an Textfield for userinput and an add button for the user
  Widget _buildTextFieldWithButton() {
    //bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_userInput);
    String? error = null;
    return QuestionInputField(errorText: error, fieldController: _userInputController, onTextFieldChanged: _updateState, onEditingComplete: _addQuestionToList, onButtonPress: _addQuestionToList, hintTextField: 'I dont know hoe',);
  }


  ///Builds a button to redirect to another page
  Widget _buildElevatedButton(String text) {
    return CustomElevatedButton(widget: Text(
      text,
      style: TextStyle(fontSize: 22),
    ),
      borderRadius: 10,
      onPressed: () => _addQuestionsAndPlayGame(), //TODO redirect.
      color: const Color(0xFF000434),
    );
  }

  void _addQuestionsAndPlayGame(){
    userQuestions.forEach((question) => widget.openQuestionRegister.add(question));
    widget.onDone();
  }

  ///Adds a question to the register and wipes the textfield
  void _addQuestionToList() {

    OpenQuestion question = OpenQuestion(questionId: questionId, questionText: _userInput);
    questionId++;
    userQuestions.add(question);
    _userInputController.clear();
    _updateState();
  }


  ///Removes a question from the list
  void _removeQuestionFromList(Question question) {
    userQuestions.remove(question);
    questionId--;
    _updateState();
  }

  ///refreshes the state - rebuilds components
  void _updateState() {
    setState(() {});
  }

}