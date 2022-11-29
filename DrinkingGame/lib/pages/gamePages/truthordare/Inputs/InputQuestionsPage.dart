import 'package:drinkinggame/components/GameInputForm.dart';
import 'package:drinkinggame/components/QuestionInputField.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/model/enums/TruthOrDare.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/model/registers/TruthOrDareRegister.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/CustomText.dart';
import '../../../../components/forms/textfields/TextFields.dart';
import '../../../../model/Player.dart';

class InputQuestionsPage extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {

  InputQuestionsPage({required this.playerRegister, required this.truthOrDareRegister, required this.onDone, Key? key}) : super(key: key);

  PlayerRegister playerRegister;

  TruthOrDareRegister truthOrDareRegister;

  VoidCallback onDone;


  @override
  ConsumerState<InputQuestionsPage> createState() => _CustomQuestionInputPageState();
}

class _CustomQuestionInputPageState extends ConsumerState<InputQuestionsPage> {

  ///Controller for the textfield
  final TextEditingController _userInputController = TextEditingController();


  ///Getter for input player writes in the textfield
  String get _userInput => _userInputController.text;

  bool _submitted = false;

  ///Bool for switching between adding truths or dares
  bool _isTruth = true;

  bool firstTime = true;

  ///Local array for the truths and dares the user creates
  ///Used for merging with ALL the questions
  List<TruthOrDareQuestion> userQuestions = [];

  Player? _currentPlayer;

  int questionId = 1;

  int _playerId = 1;

  ///Build the page
  @override
  Widget build(BuildContext context) {
    if(firstTime){
      getNextPlayer();
      firstTime = false;
    }

    Widget textField = _buildTextFieldWithButton();
    String titleText = "Write in your ${_isTruth ? "Truth(s)" : "Dare(s)"}" ;
    Widget widgetToShow = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildContent(GameInputForm(formTitle: titleText, textField: textField, underWidget: _makeSwitchTruthOrDareButton(),)),
      ),
    );


    if(_currentPlayer == null){
      widgetToShow = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildElevatedButton("Next page", widget.onDone),
        ],
      );
    }

    return widgetToShow;
  }

  ///Makes the truth or dare switch button.
  ///Returns the button
  Widget _makeSwitchTruthOrDareButton(){
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: _buildElevatedButton(_isTruth ? "Change to dare" : "Change to truth",
          _switchTruthOrDare),
    );
  }

  List<Widget> _buildContent(GameInputForm gameInputForm) {
    return [
      gameInputForm,

      CustomText(text: "Truth or dare", fontSize: 30, fontWeight: FontWeight.w600),
      _buildAddedPlayersList(),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: _buildElevatedButton("Add questions", mergePlayerQuestionsWithQuestionList),
          ),
        ],
      )
    ];
  }

  ///Builds an Textfield for userinput and an add button for the user
  Widget _buildTextFieldWithButton() {
    ///TODO:Replace with truth validator
    bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_userInput);
    String? error = null;
    if(playerErrorText){
      String truthOrDare = _isTruth ? "truth" : "dare";
      error = "Invalid ${truthOrDare}";
    }
    return QuestionInputField(errorText: error, hintTextField: _isTruth ? "truth" : "dare",fieldController: _userInputController, onTextFieldChanged: _updateState, onEditingComplete: _addQuestionToList, onButtonPress: _addQuestionToList);
  }

  ///Builds a scrollable list of the existing users with a delete button
  Widget _buildAddedPlayersList() {
    List<Question> questions = widget.truthOrDareRegister.getRegisterItems();
    print(questions.map((e) => e.getQuestionText()));
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
        child: Center(
          ///A fixed size for the scrollable list
            child: SizedBox(
              height: 165,
              ///Scrollable list for displaying users
              child: ListView(
                shrinkWrap: true,
                children: [
                  ///Loops through the players list and creates a
                  ///component for each player
                  for (Question question in userQuestions)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 35),
                        Expanded(child:
                        Text(question.getQuestionText(),
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.clip,)),
                        TextButton(onPressed: () => _removeQuestionFromList(question), child: Column(
                          children: const [
                            SizedBox(height: 5),
                            Icon(CupertinoIcons.minus, size: 30,),
                          ],
                        )),
                      ],),
                ],
              ),
            )
        )
    );
  }

  void _switchTruthOrDare() {
      _isTruth = !_isTruth;
       print(_isTruth);
      _updateState();
  }

  void mergePlayerQuestionsWithQuestionList() {
    List<Question> questions = widget.truthOrDareRegister.getRegisterItems();
    questions.addAll(userQuestions);
    userQuestions.clear();
    _updateState();
    print(questions.map((e) => e.getQuestionText()));
    getNextPlayer();
  }

  ///Gets the next player.
  void getNextPlayer(){
    try{
      _currentPlayer = widget.playerRegister.getPlayerById(_playerId);
      _playerId++;
    }catch(e){
      _currentPlayer = null;
    }
  }

  ///Builds a button to redirect to another page
  Widget _buildElevatedButton(String text, Function onPressed) {
    return CustomElevatedButton(widget: Text(
      text,
      style: TextStyle(fontSize: 22),
    ),
      borderRadius: 10,
      onPressed: () => onPressed(),
      color: const Color(0xFF000434),
    );
  }

  Widget _buildCustomButton(Widget widget, double height, double borderRadius, Function onPressed, Color color) {
    return SizedBox(
        height: height,
        child: ElevatedButton(
          onLongPress: (){print("PEPE");},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)))),
            backgroundColor: MaterialStateColor.resolveWith((states) => color),
          ),
          onPressed: () => onPressed(),
          child: widget,
        ),
    );
  }


  ///Adds a question to the register and wipes the textfield
  void _addQuestionToList() {
    TruthOrDareQuestion question = TruthOrDareQuestion(questionId: questionId, questionText: _userInput, madeBy: _currentPlayer!, truthOrDare: _isTruth ? TruthOrDare.TRUTH : TruthOrDare.DARE);
    questionId++;
    userQuestions.add(question);
    _updateState();
    _userInputController.clear();
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