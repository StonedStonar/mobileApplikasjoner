import 'package:drinkinggame/components/Dialogs.dart';
import 'package:drinkinggame/components/GameInputForm.dart';
import 'package:drinkinggame/components/QuestionInputField.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/buttons/ElevatedIconButton.dart';
import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/InputQuestionsPage.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/CustomText.dart';
import '../../../../components/forms/textfields/TextFields.dart';

class InputPlayersInputPage extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {

  ///Makes an instance of the players input page
  ///[playerRegister] the player register
  ///[onDone] the function to do when its done.
  InputPlayersInputPage({required this.playerRegister, required VoidCallback onDone, Key? key}) : _onDone = onDone,super(key: key);

  VoidCallback _onDone;

  ///Gets the on done function
  VoidCallback get onDone => _onDone;

  ///Register of players
  PlayerRegister playerRegister;

  @override
  ConsumerState<InputPlayersInputPage> createState() => _CustomPlayerInputPageState();
}

class _CustomPlayerInputPageState extends ConsumerState<InputPlayersInputPage> {

  ///Controller for the textfield
  final TextEditingController _playerInputController = TextEditingController();

  ///Getter for input player writes in the textfield
  String get _playerInput => _playerInputController.text;

  ///Bool for verifying if a textfield is submitted
  ///true for submitted, false if not
  bool _submitted = false;

  ///Bool for verifying that there are minimally two players in the game
  ///true for if there are more than two players, false if not
  bool atleastTwoPlayers = false;

  ///For giving each player a unique id
  int playerId = 1;

  @override
  Widget build(BuildContext context) {
    GameInputForm gameInputForm = GameInputForm(formTitle: "Write in the name of the players", textField: _buildTextFieldWithButton());
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildChildren(gameInputForm),
        )
    );
  }

  ///Builds the all associated widgets for the page
  ///Returns the children
   List<Widget> _buildChildren(GameInputForm gameInputForm) {
    return [
        gameInputForm,
        CustomText(text: "Players in game", fontSize: 30, fontWeight: FontWeight.w600),
        _buildAddedPlayersList(),

         Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
         child: _buildNextPageButton())
      ];
  }

  ///Builds an Textfield for userinput and an add button for the user
  ///Returns the widget
  Widget _buildTextFieldWithButton() {
    ///Display error text if the form is submitted AND credentials are invalid
    bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_playerInput);
    String? error = null;
    if(playerErrorText){
      error = "playername";
    }
    return QuestionInputField(errorText: error, hintTextField: "playername",fieldController: _playerInputController,
        onTextFieldChanged: _updateState, onEditingComplete: _addPlayerToList, onButtonPress: _addPlayerToList);
  }

  ///Builds a scrollable list of the existing users with a delete button
  ///Returns the added player list
  Widget _buildAddedPlayersList() {
    List<Player> players = widget.playerRegister.getRegisterItems();
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 10, 25),
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
                  for (Player player in players)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 35),
                        Expanded(child:
                        Text(player.getPlayerName(),
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.clip,)),
                        TextButton(onPressed: () => _removePlayerFromList(player), child: Column(
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

  ///Builds a button to redirect to another page
  ///Returns the next page button
  Widget _buildNextPageButton() {
    return CustomElevatedButton(widget: Text(
            "Next page",
            style: TextStyle(fontSize: 22),
          ),
            borderRadius: 10,
            onPressed: atleastTwoPlayersAdded()
                ? widget.onDone
                : () => showAlertDialog(
                context,
                title: "Oops!",
                content: "There must be atleast two players in the game",
                defaultActionText: "Ok"),
            color: const Color(0xFF000434),
    );
  }

  ///Adds a player to the register IF the user´s input is valid
  /// then wipes the textfield
  void _addPlayerToList() {
    _submitted = true;
    if(validatePlayerInput()) {
      playerId++;
      Player player = Player(playerID: playerId, playerName: _playerInput);
      widget.playerRegister.addPlayer(player);
      _playerInputController.clear();
      _submitted = false;
    }
    _updateState();
  }

  ///Validates the user input according to business logic
  ///Returns true if the username is valid. False otherwise
  bool validatePlayerInput() {
    return widget.usernameValidator.isValid(_playerInput);
  }

  ///Removes a player from the list
  void _removePlayerFromList(Player player) {
    widget.playerRegister.removePlayer(player);
    playerId--;
    _updateState();
  }

  ///Checks if there are atleast two players in the register,
  ///Returns true if there are two players
  bool atleastTwoPlayersAdded() {
    if(widget.playerRegister.getRegisterItems().length >= 2) {
      atleastTwoPlayers = true;
      _updateState();
    }
    return atleastTwoPlayers;
  }

  ///Refreshes the state - rebuilds components
  void _updateState() {
    setState(() {});
  }
}