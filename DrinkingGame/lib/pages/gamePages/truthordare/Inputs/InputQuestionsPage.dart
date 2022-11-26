import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/model/enums/TruthOrDare.dart';
import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:drinkinggame/model/registers/OpenQuestionRegister.dart';
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

class InputQuestionsPage extends ConsumerStatefulWidget {

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

  bool atleastTwoQuestions = false;

  ///Build the page
  @override
  Widget build(BuildContext context) {
    if(firstTime){
      getNextPlayer();
      firstTime = false;
    }
    Widget widgetToShow = SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 45, 5, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren(),
          )

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

  List<Widget> _buildChildren() {
    return [
      CustomText(text: _currentPlayer != null ? _currentPlayer!.getPlayerName() : "", fontSize: 35, fontWeight: FontWeight.w500),
      const SizedBox(height: 20),
      CustomText(text: _isTruth ? "Write in your truth(s)" : "Write in your dare(s)",
          fontSize: 30, fontWeight: FontWeight.w600),
      const SizedBox(height: 20),

      _buildTextFieldWithButton(),
      const SizedBox(height: 20),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: _buildElevatedButton(_isTruth ? "Change to dare" : "Change to truth",
            _switchTruthOrDare),
      ),
      SizedBox(height: 10),

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
    bool questionErrorText = _submitted && !validateUserInput();
    return Container(
      margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            ///The textfield
            child: buildGameUserTextField(
                "Enter question",
                "Question must be between 1 - 150 characters",
                _userInputController,
                _updateState,
                questionErrorText,
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
    List<Question> questions = widget.truthOrDareRegister.getRegisterItems();
    print(questions.map((e) => e.getQuestionText()));
    List<Widget> questionWidgets = [];
    userQuestions.forEach((question) {
      questionWidgets.add(makeWidgetForQuestion(question));
    });
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Center(
          ///A fixed size for the scrollable list
            child: SizedBox(
              height: 165,
              ///Scrollable list for displaying users
              child: userQuestions.isNotEmpty ? ListView(
                shrinkWrap: true,
                children: questionWidgets,
              ) : SizedBox(
                  height: 10,
                  child: CustomText(text: "No questions", fontSize: 20, fontWeight: FontWeight.w300)),
            )
        )
    );
  }

  Widget makeWidgetForQuestion(Question question){
    return Row(
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
      ]);
  }

  void _nextPage() {

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

  bool atleastTwoQuestionsAdded() {
    if(widget.truthOrDareRegister.getRegisterItems().length >= 2) {
      atleastTwoQuestions = true;
      _updateState();
    }
    return atleastTwoQuestions;
  }

  ///Adds a question to the register and wipes the textfield
  void _addQuestionToList() {
    _submitted = true;
    if(validateUserInput()) {
      TruthOrDareQuestion question = TruthOrDareQuestion(
          questionId: questionId,
          questionText: _userInput,
          madeBy: _currentPlayer!,
          truthOrDare: _isTruth ?
          TruthOrDare.TRUTH :
          TruthOrDare.DARE);
      questionId++;
      userQuestions.add(question);
      _submitted = false;
      _userInputController.clear();
      print(userQuestions.length);
    }
    _updateState();
  }

  bool validateUserInput() {
    if(_userInput.length > 1 && _userInput.length < 150) {
      return true;
    } else {
      return false;
    }
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