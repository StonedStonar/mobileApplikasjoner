import 'package:drinkinggame/components/CustomText.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/AuthProvider.dart';
import '../AppBars.dart';
import '../Dialogs.dart';
import '../buttons/CustomElevatedButton.dart';


class EditProfileForm extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators {
  EditProfileForm({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileForm> createState() => EditProfileFormState();
}

class EditProfileFormState extends ConsumerState<EditProfileForm>{

  ///TextEditingControllers for getting user input
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
  String get _confirmationPassword => _confirmationPasswordController.text;

  ///True when the user has clicked submit atleast once
  bool _submittedUser = false;
  bool _submittedEmail = false;
  bool _submittedPassword = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildChildren(),
            )
        ),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      CustomText(text: "Current username: ${ref.watch(authProvider).currentUser?.displayName}",
          fontSize: 20,
          fontWeight: FontWeight.w400),
      _buildEditUsernameWidget(),
      SizedBox(height: 20,),
      CustomText(text: "Current email: ${ref.watch(authProvider).currentUser?.email}",
          fontSize: 20,
          fontWeight: FontWeight.w400),
      _buildEditEmailWidget(),
      SizedBox(height: 20,),
      _buildEditPasswordWidget()
  ];
}

  Widget _buildEditUsernameWidget() {
    bool usernameErrorText = _submittedUser && !widget.usernameValidator.isValid(_editUsername);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildUsernameTextField(_editUsernameController,
            _editUsernameFocusNode,
            _updateState,
            "New username",
            "Your new username",
            usernameErrorText,
            false,
            _updateUserName,
            "new_username"),
        SizedBox(height: 10,),
        ///Submit form button
        CustomElevatedButton(widget: Text(
          "Change username",
          style: TextStyle(fontSize: 22),
        ),
          borderRadius: 10,
          onPressed:  _isLoading ? null : _updateUserName,
          color: const Color(0xFF000434),
        )
      ],
    );
  }

  Widget _buildEditEmailWidget() {
    bool emailErrorText = _submittedEmail && !widget.emailValidator.isValid(_editEmail);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildEmailTextField(_editEmailController,
            _editEmailFocusNode,
            _updateState,
            "New email",
            "Your new email",
            emailErrorText,
            false,
            _updateEmail,
            "new_email"),

        SizedBox(height: 10,),

        ///Submit form button
        CustomElevatedButton(widget: Text(
          "Change email",
          style: TextStyle(fontSize: 22),
        ),
          borderRadius: 10,
          onPressed: _isLoading ? null : _updateEmail,
          color: const Color(0xFF000434),
        )
      ],
    );
  }

  Widget _buildEditPasswordWidget() {
    bool passwordErrorText = _submittedPassword && !widget.passwordValidator.isValid(_editPassword);
    bool confirmationErrorText = _submittedPassword && !_comparePasswords();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildPasswordTextField(_editPasswordController,
            _editPasswordFocusNode,
            _updateState,
            "New password",
            "Your new password",
            passwordErrorText,
            false,
            TextInputAction.done,
            _updatePassword,
            "old_password"),

        SizedBox(height: 10,),

        buildConfirmPasswordTextField(_confirmationPasswordController,
            _confirmPasswordFocusNode,
            _updateState,
            "Confirm password",
            "Rewrite your Password",
            confirmationErrorText,
            false,
            TextInputAction.done,
            _updatePassword,
            "confirm_password"),

        SizedBox(height: 10,),

        ///Submit form button
        CustomElevatedButton(widget: Text(
          "Change password",
          style: TextStyle(fontSize: 22),
        ),
          borderRadius: 10,
          onPressed: _isLoading ? null : _updatePassword,
          color: const Color(0xFF000434),
        ),
      ],
    );
  }

  ///Sets the new username in firebase
  void _updateUserName() async {
    setState(() {
      _submittedUser = true;
    });
    if(widget.usernameValidator.isValid(_editUsername)) {
      _isLoading = true;
      await ref.watch(authProvider).currentUser!.updateDisplayName(_editUsername);
      _isLoading = false;
    }
  }

  void _updateEmail() async {
    setState(() {
       _submittedEmail = true;
    });
    if(widget.emailValidator.isValid(_editEmail)) {
      await ref.watch(authProvider).currentUser!.updateEmail(_editEmail);
    }
  }

  void _updatePassword() async {
    setState(() {
      _submittedPassword = true;
    });
    if(widget.passwordValidator.isValid(_editPassword) && _comparePasswords()) {
      try {
        await ref.watch(authProvider).currentUser!.updatePassword(_editPassword);
      } on FirebaseAuthException catch(e) {
        ///Displays an alert dialog if an error occurs
        showAlertDialog(context,
            title: "Error",
            content: "An error occured setting a new password. "
                "Try logging in to your account again",
            defaultActionText: "Ok");
      }
    }
  }

  ///Compares the two passwords input by the user
  bool _comparePasswords() {
    return _editPassword == _confirmationPassword;
  }

  ///Updates the state - rebuilds components
  void _updateState() {
    setState(() {});
  }
}
