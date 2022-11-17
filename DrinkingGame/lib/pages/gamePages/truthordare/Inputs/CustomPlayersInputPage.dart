import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/buttons/ElevatedIconButton.dart';
import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/CustomQuestionsPage.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/CustomText.dart';
import '../../../../components/forms/textfields/TextFields.dart';

class CustomPlayersInputPage extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {
  CustomPlayersInputPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomPlayersInputPage> createState() => _CustomPlayerInputPageState();
}

class _CustomPlayerInputPageState extends ConsumerState<CustomPlayersInputPage> {

  ///Controller for the textfield
  final TextEditingController _playerInputController = TextEditingController();

  ///Getter for input player writes in the textfield
  String get _playerInput => _playerInputController.text;

  bool _submitted = false;

  ///Register of players
  PlayerRegister playerRegister = PlayerRegister();

  int playerId = 1;

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
        buildHeadLineText("Write in the names of \n the players", 30, FontWeight.w600),
        const SizedBox(height: 20),
        _buildTextFieldWithButton(),
        const SizedBox(height: 40),

        buildHeadLineText("Players in game", 30, FontWeight.w600),
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
    List<Player> players = playerRegister.getPlayers();
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
            onPressed: () => CustomQuestionsInputPage(),
            color: const Color(0xFF000434),
    );
  }

  ///Adds a player to the register and wipes the textfield
  void _addPlayerToList() {
    Player player = Player(playerID: playerId, playerName: _playerInput);
    playerRegister.addPlayer(player);
    _updateState();
    _playerInputController.clear();
  }

  ///Removes a player from the list
  void _removePlayerFromList(Player player) {
    playerRegister.removePlayer(player);
    playerId--;
    _updateState();
  }

  ///refreshes the state - rebuilds components
  void _updateState() {
    setState(() {});
  }

}