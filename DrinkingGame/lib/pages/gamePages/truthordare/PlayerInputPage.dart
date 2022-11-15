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

  PlayerRegister? playerRegister;

  static int playerId = 0;

  @override
  Widget build(BuildContext context) {
    bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_playerInput);
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
          child: _buildPlayerInputField(),
        )
      ),
    );
  }

  Widget _buildPlayerInputField() {
    return Column(
      children: [
        Text(
          "Write in the names of the players",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        _buildTextFieldWithButton()
      ],
    );
  }

  Widget _buildTextFieldWithButton() {
    bool playerErrorText = _submitted && !widget.usernameValidator.isValid(_playerInput);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: buildPlayerTextField(_playerInputController, _updateState, playerErrorText, _addPlayerToList),
          ),
        ),
        TextButton(onPressed: _addPlayerToList, child: Column(
          children: [
            SizedBox(height: 10),
            Icon(CupertinoIcons.add, size: 30,),
            Text("Add", style: TextStyle(fontSize: 14),)
          ],
        ))
      ],
    );
  }

  void _addPlayerToList() {
    Player(playerID: playerId++, playerName: _playerInput);
    playerRegister?.addPlayer(Player(playerID: playerId++, playerName: _playerInput));
  }

  void _updateState() {
    setState(() {});
  }
}