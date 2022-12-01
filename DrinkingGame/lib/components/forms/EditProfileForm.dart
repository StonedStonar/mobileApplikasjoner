import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/AuthProvider.dart';
import '../AppBars.dart';
import '../buttons/CustomElevatedButton.dart';


class EditProfileForm extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {
  EditProfileForm({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileForm> createState() => EditProfileFormState();
}

class EditProfileFormState extends ConsumerState<EditProfileForm>{

  ///TexteditingControllers for getting user input
  final TextEditingController _editUsernameController = TextEditingController();
  final TextEditingController _editEmailController = TextEditingController();
  final TextEditingController _editPasswordController = TextEditingController();
  final TextEditingController _confirmationPasswordController = TextEditingController();


  final FocusNode _editUsernameFocusNode = FocusNode();
  final FocusNode _editEmailFocusNode = FocusNode();
  final FocusNode _editPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();


  ///Simplified getters for the user input
  String get _editUsername => _editUsernameController.text;
  String get _editEmail => _editEmailController.text;
  String get _editPassword => _editPasswordController.text;
  String get _editConfirmationPassword => _confirmationPasswordController.text;

  ///True when the user has clicked submit atleast once
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: makeBasicAppbar("Edit username"),

      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildEditUsernameWidget(),
            )
        ),
      ),
    );
  }

  List<Widget> _buildEditUsernameWidget() {
    bool usernameErrorText = _submitted && !widget.usernameValidator.isValid(_editUsername);
    return [

      buildUsernameTextField(_editUsernameController,
          _editUsernameFocusNode,
          _updateState,
          "New username",
          "Your new username",
          usernameErrorText,
          false,
          _submit,
          "new_username"),

      ///Submit form button
      CustomElevatedButton(widget: Text(
        "Change username",
        style: TextStyle(fontSize: 22),
      ),
        borderRadius: 10,
        onPressed: _submit,
        color: const Color(0xFF000434),
      )
    ];
  }

  List<Widget> _buildEditEmailWidget() {
    bool usernameErrorText = _submitted && !widget.usernameValidator.isValid(_editUsername);
    return [

      buildUsernameTextField(_editUsernameController,
          _editUsernameFocusNode,
          _updateState,
          "New email",
          "Your new email",
          usernameErrorText,
          false,
          _submit,
          "new_email"),

      ///Submit form button
      CustomElevatedButton(widget: Text(
        "Change username",
        style: TextStyle(fontSize: 22),
      ),
        borderRadius: 10,
        onPressed: _submit,
        color: const Color(0xFF000434),
      )
    ];
  }

  ///Updates the state - rebuilds components
  void _updateState() {
    setState(() {});
  }

  ///Sets the new username in firebase
  void changeUserName() {
    ref.watch(authProvider).currentUser!.updateDisplayName(_editUsername);
  }

  ///Submits the changed username
  void _submit() {
    setState(() {
      _submitted = true;
    });
    if(widget.usernameValidator.isValid(_editUsername)) {
      changeUserName();
      Navigator.of(context).pop();
    }
  }
}
