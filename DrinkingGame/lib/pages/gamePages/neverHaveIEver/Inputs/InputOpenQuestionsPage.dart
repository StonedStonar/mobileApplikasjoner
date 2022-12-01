import 'package:drinkinggame/components/GameInputForm.dart';
import 'package:drinkinggame/components/QuestionInputField.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../components/CustomText.dart';
import '../../../../model/games/OpenQuestionGame.dart';

///Represents the input of open questions page, where the player write their own questions.
class InputOpenQuestionsPage extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {


  ///Makes an instance of input open questions page.
  ///[game] the open question game-
  ///[onDone] Callback called when players are done with making questions.
  ///[key]
  InputOpenQuestionsPage({required this.game, required this.onDone, Key? key}) : super(key: key);


  ///The register of questions to show players.
  OpenQuestionGame game;

  ///Callback for when question is answered and done.
  VoidCallback onDone;


  @override
  ConsumerState<InputOpenQuestionsPage> createState() => _CustomNeverHaveIEverQuestionInputPageState();
}

///Representing the state for when
class _CustomNeverHaveIEverQuestionInputPageState extends ConsumerState<InputOpenQuestionsPage> {

  ///Controller for the textfield
  final TextEditingController _userInputController = TextEditingController();


  ///Getter for input player writes in the textfield
  String get _userInput => _userInputController.text;



  ///Local array for the truths and dares the user creates
  ///Used for merging with ALL the questions
  List<OpenQuestion> userQuestions = [];

  int questionId = 1;


  ///Builds the page.
  @override
  Widget build(BuildContext context) {

    Widget textField = _buildTextFieldWithButton();
    String titleText = "Write in your ${widget.game.getStatementName()}" ;
    Widget widgetToShow = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildContent(GameInputForm(formTitle: titleText, textField: textField)),
      ),
    );

    print(userQuestions.length);
    return widgetToShow;
  }

  ///Builds the content of the page.
  List<Widget> _buildContent(GameInputForm gameInputForm) {
    List<Widget> widgets = [];
    userQuestions.forEach((question) => widgets.add(_makeQuestionWidget(question)));
    return [
      gameInputForm,
      CustomText(text: widget.game.getStatementName(), fontSize: 30, fontWeight: FontWeight.w600),
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

  ///Makes a questions widget
  Widget _makeQuestionWidget(OpenQuestion openQuestion){
    //Todo: Style this you trønder
    return Text(openQuestion.getQuestionText());
  }

  ///Builds an Textfield for userinput and an add button for the user
  Widget _buildTextFieldWithButton() {
    String? error = null;
    return QuestionInputField(errorText: error, fieldController: _userInputController, onTextFieldChanged: _updateState, onEditingComplete: _addQuestionToList, onButtonPress: _addQuestionToList, hintTextField: 'I dont know hoe',);
  }


  ///Builds a button to redirect to another page
  ///[text] the text to write in the button
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

  ///Adds questions added in list, to register of questions.
  void _addQuestionsAndPlayGame(){
    OpenQuestionRegister register = widget.game.getGameRegister();
    userQuestions.forEach((question) => register.add(question));
    widget.onDone();
  }

  ///Adds a question to a list and wipes the textfield.
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