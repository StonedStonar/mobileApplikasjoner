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

class InputQuestionsPage extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {

  InputQuestionsPage({Key? key}) : super(key: key);



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
  bool _truthOrDare = true;

  ///Register of players
  PlayerRegister playerRegister = PlayerRegister();

  ///Todo: Bruk heller player question register siden du skal lage spørsmål for spillere. Så kan vi få til hele logikken senere.
  OpenQuestionRegister questionRegister = OpenQuestionRegister();

  ///Local array for the truths and dares the user creates
  ///Used for merging with ALL the questions
  List<Question> userQuestions = [];

  int questionId = 1;

  ///Build the page
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 65, 5, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren(),
          )

      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      buildHeadLineText(_truthOrDare ? "Write in your truth(s)" : "Write in your dare(s)",
          30, FontWeight.w600),
      const SizedBox(height: 20),

      _buildTextFieldWithButton(),
      const SizedBox(height: 20),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: _buildElevatedButton(_truthOrDare ? "Change to dare" : "Change to truth",
            _switchTruthOrDare),
      ),
      SizedBox(height: 10),

      buildHeadLineText("Truth or dare", 30, FontWeight.w600),
      _buildAddedPlayersList(),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: _buildElevatedButton("Add questions", mergePlayerQuestionsWithQuestionList),
          ),


             SizedBox(
               width: 200,
                 child: _buildElevatedButton("Next page", _nextPage)
             )
        ],
      )
    ];
  }

  ///Builds an Textfield for userinput and an add button for the user
  Widget _buildTextFieldWithButton() {
    ///TODO:Replace with truth validator
    bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_userInput);
    return Container(
      margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            ///The textfield
            child: buildGameUserTextField(
                _truthOrDare ? "truth" : "dare",
                _userInputController,
                _updateState,
                playerErrorText,
                _addQuestionToList),
          ),
          ///Button to add player to the register
          TextButton(onPressed: _addQuestionToList, child: Column(
            children: const [
              SizedBox(height: 11),
              Icon(CupertinoIcons.add, size: 30,),
              Text("Add", style: TextStyle(fontSize: 14),)
            ],
          ))
        ],
      ),
    );
  }

  ///Builds a scrollable list of the existing users with a delete button
  Widget _buildAddedPlayersList() {
    List<Question> questions = questionRegister.getRegisterItems();
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

  void _nextPage() {

  }

  void _switchTruthOrDare() {
      _truthOrDare = !_truthOrDare;
       print(_truthOrDare);
      _updateState();
  }

  void mergePlayerQuestionsWithQuestionList() {
    List<Question> questions = questionRegister.getRegisterItems();
    questions.addAll(userQuestions);
    userQuestions.clear();
    _updateState();
    print(questions.map((e) => e.getQuestionText()));
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
    OpenQuestion question = OpenQuestion(questionId: questionId, questionText: _userInput);
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