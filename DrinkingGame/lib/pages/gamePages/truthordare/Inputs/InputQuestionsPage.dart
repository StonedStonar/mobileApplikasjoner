import 'package:drinkinggame/components/Dialogs.dart';
import 'package:drinkinggame/components/QuestionWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/CustomText.dart';
import '../../../../components/forms/GameInputForm.dart';
import '../../../../components/QuestionInputField.dart';
import '../../../../components/buttons/CustomElevatedButton.dart';
import '../../../../model/Player.dart';
import '../../../../model/enums/TruthOrDare.dart';
import '../../../../model/questions/Question.dart';
import '../../../../model/questions/TruthOrDareQuestion.dart';
import '../../../../model/registers/PlayerRegister.dart';
import '../../../../model/registers/TruthOrDareRegister.dart';

///Page for a user to add custom questions to a game
class InputQuestionsPage extends ConsumerStatefulWidget {
  ///Makes an instance of the input questions page.
  ///[playerRegister] the player register
  ///[truthOrDareRegister] the truth or dare register
  ///[onDone] the on done function
  InputQuestionsPage(
      {required this.playerRegister,
      required this.truthOrDareRegister,
      required VoidCallback onDone,
      Key? key})
      : _onDone = onDone,
        super(key: key);

  ///Register for all players
  PlayerRegister playerRegister;

  ///Register for all truths and dares
  TruthOrDareRegister truthOrDareRegister;

  ///Function to be called when all players have inputted their questions
  VoidCallback _onDone;

  ///Gets the on done function.
  VoidCallback get onDone => _onDone;

  @override
  ConsumerState<InputQuestionsPage> createState() =>
      _CustomQuestionInputPageState();
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

  ///The current player inputting questions
  Player? _currentPlayer;

  ///For giving each question a unique ID
  int questionId = 1;

  late Iterator<Player> it;

  ///Build the page
  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      it = widget.playerRegister.getIterator();
      getNextPlayer();
      firstTime = false;
    }

    Widget textField = _buildTextFieldWithButton();
    String titleText =
        "${_currentPlayer?.getPlayerName()} write in your ${_isTruth ? "Truth(s)" : "Dare(s)"}";
    Widget widgetToShow = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildContent(GameInputForm(
          formTitle: titleText,
          textField: textField,
          underWidget: _makeSwitchTruthOrDareButton(),
        )),
      ),
    );

    ///If there are no more players, display a button for advancing to the game.
    if (_currentPlayer == null) {
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
  Widget _makeSwitchTruthOrDareButton() {
    return _buildElevatedButton(
        _isTruth ? "Change to dare" : "Change to truth", _switchTruthOrDare);
  }

  ///Builds the content
  ///[gameInputForm] the game input form.
  ///Returns the content
  List<Widget> _buildContent(GameInputForm gameInputForm) {
    return [
      gameInputForm,
      CustomText(
          text: "Truth or dare", fontSize: 30, fontWeight: FontWeight.w600),
      _buildAddedPlayersList(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: _buildElevatedButton("Add questions", moveToNextPlayer),
          ),
        ],
      )
    ];
  }

  ///Builds an Textfield for userinput and an add button for the user
  ///Returns the textfield with button
  Widget _buildTextFieldWithButton() {
    ///TODO:Replace with truth validator
    bool playerErrorText = _submitted && !validateUserInput();
    String? error = null;
    if (playerErrorText) {
      String truthOrDare = _isTruth ? "truth" : "dare";
      error = "From 1 to 150 characters. Current length: ${_userInput.length}";
    }
    return QuestionInputField(
        errorText: error,
        hintTextField: _isTruth ? "truth" : "dare",
        fieldController: _userInputController,
        onTextFieldChanged: _updateState,
        onEditingComplete: _addQuestionToList,
        onButtonPress: _addQuestionToList);
  }

  ///Builds a scrollable list of the existing users with a delete button
  ///Returns the widget.
  Widget _buildAddedPlayersList() {
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
          child: userQuestions.isNotEmpty
              ? ListView(
                  shrinkWrap: true,
                  children: questionWidgets,
                )
              : SizedBox(
                  height: 10,
                  child: CustomText(
                      text: "No questions",
                      fontSize: 20,
                      fontWeight: FontWeight.w300)),
        )));
  }

  ///Makes a widget for a question with a button to remove it
  ///[question] the truth or dare question
  ///Returns the question widget.
  Widget makeWidgetForQuestion(TruthOrDareQuestion question) {
    return QuestionWidget(question: question, onPressed: _removeQuestionFromList);
  }

  ///Switches between adding a truth or a dare question.
  void _switchTruthOrDare() {
    _isTruth = !_isTruth;
    _updateState();
  }

  ///When a player is done adding questions, add the user questions to the
  ///general list of questions to be displayed. Then get a new player.
  void moveToNextPlayer() {
    if (_atleastOneQuestionAdded()) {
      mergePlayerQuestionsWithQuestionList();
      getNextPlayer();
    } else {
      showAlertDialog(context,
          title: "Oops!",
          content: "Every player must add atleast 1 question",
          defaultActionText: "Ok");
    }
  }

  ///Merges a player??s questions to the general list of questions.
  void mergePlayerQuestionsWithQuestionList() {
    List<Question> questions = widget.truthOrDareRegister.getRegisterItems();
    questions.addAll(userQuestions);
    userQuestions.clear();
    _updateState();
  }

  ///Gets the next player.
  void getNextPlayer() {
    if (it.moveNext()) {
      _currentPlayer = it.current;
    } else {
      _currentPlayer = null;
    }
  }

  ///Builds a button to redirect to another page
  ///[text] the text of the elevated button
  ///[onPressed] the on pressed function
  ///Returns the widget
  Widget _buildElevatedButton(String text, Function onPressed) {
    return CustomElevatedButton(
      widget: Text(
        text,
      ),
      onPressed: () => onPressed(),
    );
  }

  ///Checks if there is atleast one question added.
  ///Returns true if there is atleast one question added. False otherwise
  bool _atleastOneQuestionAdded() {
    return userQuestions.isNotEmpty;
  }

  ///Adds a question to the register and wipes the textfield
  void _addQuestionToList() {
    _submitted = true;
    if (validateUserInput()) {
      TruthOrDareQuestion question = TruthOrDareQuestion(
          questionId: questionId,
          questionText: _userInput,
          madeBy: _currentPlayer!,
          truthOrDare: _isTruth ? TruthOrDare.TRUTH : TruthOrDare.DARE);
      questionId++;
      userQuestions.add(question);
      _submitted = false;
      _userInputController.clear();
    }
    _updateState();
  }

  ///Checks if the length of a question is between 1 and 150 characters.
  /// Returns true if the input is larger than 1 and below 150. False otherwise
  bool validateUserInput() {
    return _userInput.isNotEmpty && _userInput.length <= 150;
  }

  ///Removes a question from the list.
  void _removeQuestionFromList(Question question) {
    userQuestions.remove(question);
    questionId--;
    _updateState();
  }

  ///refreshes the state - rebuilds components.
  void _updateState() {
    setState(() {});
  }
}
