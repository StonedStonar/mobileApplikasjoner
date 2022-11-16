import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/buttons/ElevatedIconButton.dart';
import 'package:drinkinggame/model/Player.dart';
import 'package:drinkinggame/model/registers/PlayerRegister.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/forms/textfields/TextFields.dart';

class PlayerInputPage extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {
  PlayerInputPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PlayerInputPage> createState() => _PlayerInputPageState();
}

class _PlayerInputPageState extends ConsumerState<PlayerInputPage> {

  final TextEditingController _playerInputController = TextEditingController();

  String get _playerInput => _playerInputController.text;

  bool _submitted = false;

  PlayerRegister playerRegister = PlayerRegister();

  int playerId = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 65, 5, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildPlayerInputField(),
            )

      ),
    );
  }

   List<Widget> _buildPlayerInputField() {
    ///TODO: REMOVE
    ///_fillPlayerListWithTestPlayers();
    return [
        _buildHeadText("Write in the names of \n the players", 30),
        const SizedBox(height: 20),
        _buildTextFieldWithButton(),
        const SizedBox(height: 40),
        _buildHeadText("Players in game", 25),
        _buildAddedPlayersList(),
         Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
         child: _buildNextPageButton())
      ];
  }

  Widget _buildTextFieldWithButton() {
    bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_playerInput);
    return Container(
      margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: buildPlayerTextField(_playerInputController, _updateState, playerErrorText, _addPlayerToList),
          ),
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

  Widget _buildAddedPlayersList() {
    List<Player> players = playerRegister.getPlayers();
    return Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 10, 25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (Player player in players)
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 35),
                        Text(player.getPlayerName(), style: TextStyle(fontSize: 20)),
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
    );
  }

  Widget _buildNextPageButton() {
    return CustomElevatedButton(widget: Text(
            "Next page",
            style: TextStyle(fontSize: 22),
          ),
            borderRadius: 10,
            onPressed: () {},
            color: const Color(0xFF000434),
    );
  }
  
  Widget _buildHeadText(String text, double fontSize) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
    );
  }
  
  void _addPlayerToList() {
    Player player = Player(playerID: playerId, playerName: _playerInput);
    playerRegister.addPlayer(player);
    _updateState();
    _playerInputController.clear();
  }

  void _removePlayerFromList(Player player) {
    playerRegister.removePlayer(player);
    _updateState();
  }

  void _updateState() {
    setState(() {});
  }

  ///TODO: REMOVE
  void _fillPlayerListWithTestPlayers() {
    Player player1 = Player(playerID: 1, playerName: "Fuckyou");
    Player player2 = Player(playerID: 2, playerName: "Pikachu");
    playerRegister.addPlayer(player1);
    playerRegister.addPlayer(player2);
    _updateState();
  }
}