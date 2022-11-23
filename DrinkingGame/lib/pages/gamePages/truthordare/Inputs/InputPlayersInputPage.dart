import 'package:drinkinggame/components/Dialogs.dart';
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

  InputPlayersInputPage({required this.playerRegister, required this.onDone, Key? key}) : super(key: key);

  VoidCallback onDone;

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

  bool _submitted = false;

  bool atleastTwoPlayers = false;

  int playerId = 0;

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
        CustomText(text: "Write in the names of \n the players", fontSize: 30, fontWeight: FontWeight.w600),
        const SizedBox(height: 20),
        _buildTextFieldWithButton(),
        const SizedBox(height: 40),

        CustomText(text: "Players in game", fontSize: 30, fontWeight: FontWeight.w600),
        _buildAddedPlayersList(),

         Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
         child: _buildNextPageButton())
      ];
  }

  ///Builds an Textfield for userinput and an add button for the user
  Widget _buildTextFieldWithButton() {
    bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_playerInput);
    return Container(
      margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              ///The textfield
              child: buildGameUserTextField(
                  "playername",
                  _playerInputController,
                  _updateState,
                  playerErrorText,
                  _addPlayerToList),
          ),
          ///Button to add player to the register
          TextButton(onPressed: _addPlayerToList, child: Column(
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
                title: "title",
                content: "There must be two players",
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

  bool validatePlayerInput() {
    if(widget.usernameValidator.isValid(_playerInput)) {
      return true;
    } else {
      return false;
    }
  }

  ///Removes a player from the list
  void _removePlayerFromList(Player player) {
    widget.playerRegister.removePlayer(player);
    playerId--;
    _updateState();
  }

  bool atleastTwoPlayersAdded() {
    if(widget.playerRegister.getRegisterItems().length >= 2) {
      atleastTwoPlayers = true;
      _updateState();
    }
    return atleastTwoPlayers;
  }

  ///refreshes the state - rebuilds components
  void _updateState() {
    setState(() {});
  }
}