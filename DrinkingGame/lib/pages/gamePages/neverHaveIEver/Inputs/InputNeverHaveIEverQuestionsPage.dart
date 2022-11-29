import 'package:drinkinggame/components/GameInputForm.dart';
import 'package:drinkinggame/components/QuestionInputField.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/model/questions/NeverHaveIEverQuestion.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/registers/NeverHaveIEverRegister.dart';
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

class InputNeverHaveIEverQuestionsPage extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {

  InputNeverHaveIEverQuestionsPage({required this.playerRegister, required this. neverHaveIEverRegister,required this.onDone, Key? key}) : super(key: key);

  PlayerRegister playerRegister;

  NeverHaveIEverRegister neverHaveIEverRegister;

  VoidCallback onDone;


  @override
  ConsumerState<InputNeverHaveIEverQuestionsPage> createState() => _CustomNeverHaveIEverQuestionInputPageState();
}

class _CustomNeverHaveIEverQuestionInputPageState extends ConsumerState<InputNeverHaveIEverQuestionsPage> {

  ///Controller for the textfield
  final TextEditingController _userInputController = TextEditingController();


  ///Getter for input player writes in the textfield
  String get _userInput => _userInputController.text;

  bool _submitted = false;


  ///Local array for the truths and dares the user creates
  ///Used for merging with ALL the questions
  List<NeverHaveIEverQuestion> userQuestions = [];

  Player? _currentPlayer;

  int questionId = 1;

  int _playerId = 1;

  ///Build the page
  @override
  Widget build(BuildContext context) {

    /*
    if(firstTime){
      getNextPlayer();
      firstTime = false;
    }
    */

    Widget textField = _buildTextFieldWithButton();
    String titleText = "Write in your Never Have I Ever <3 " ;
    Widget widgetToShow = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildContent(GameInputForm(formTitle: titleText, textField: textField)),
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

  List<Widget> _buildContent(GameInputForm gameInputForm) {
    return [
      gameInputForm,

      CustomText(text: "Never Have I Evah", fontSize: 30, fontWeight: FontWeight.w600),
      _buildAddedPlayersList(),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: _buildElevatedButton("Add statements", mergePlayerQuestionsWithQuestionList),
          ),
        ],
      )
    ];
  }

  ///Builds an Textfield for userinput and an add button for the user
  Widget _buildTextFieldWithButton() {
    bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_userInput);
    String? error = null;
    return QuestionInputField(errorText: error, fieldController: _userInputController, onTextFieldChanged: _updateState, onEditingComplete: _addQuestionToList, onButtonPress: _addQuestionToList, hintTextField: 'I dont know hoe',);
  }

  ///Builds a scrollable list of the existing users with a delete button
  Widget _buildAddedPlayersList() {
    List<Question> questions = widget.neverHaveIEverRegister.getRegisterItems();
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


  void mergePlayerQuestionsWithQuestionList() {
    List<Question> questions = widget.neverHaveIEverRegister.getRegisterItems();
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

    NeverHaveIEverQuestion question = NeverHaveIEverQuestion(questionId: questionId, questionText: _userInput,  madeBy: _currentPlayer!);
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