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

///Form for editing values of a user
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

  ///Focusnodes for changing textfields efficiently using the mobile keyboard
  final FocusNode _editUsernameFocusNode = FocusNode();
  final FocusNode _editEmailFocusNode = FocusNode();
  final FocusNode _editPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  ///Simplified getters for the user input
  String get _editUsername => _editUsernameController.text;
  String get _editEmail => _editEmailController.text;
  String get _editPassword => _editPasswordController.text;
  String get _confirmationPassword => _confirmationPasswordController.text;

  ///Bool to see if the user has submitted the associated form atleast once
  bool _submittedUser = false;

  ///Bool to see if the user has submitted the associated form atleast once
  bool _submittedEmail = false;

  ///Bool to see if the user has submitted the associated form atleast once
  bool _submittedPassword = false;

  ///Bool to disable buttons while the application is loading data
  bool _isLoading = false;

  ///Builds the page
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

  ///Combines all widgets in the form and returns them as a list
  ///Returns the children.
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

  ///Builds associated textfield and submit button required for editing a password
  ///Returns the widget
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
          onPressed:  _isLoading ? null : _updateUserName,
          color: const Color(0xFF000434),
        )
      ],
    );
  }

  ///Builds associated textfield and submit button required for editing an email
  ///Returns the widget
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
          onPressed: _isLoading ? null : _updateEmail,
          color: const Color(0xFF000434),
        )
      ],
    );
  }

  ///Builds associated textfields and submit button required for editing a password
  ///Returns the widget
  Widget _buildEditPasswordWidget() {
    bool passwordErrorText = _submittedPassword && !widget.passwordValidator.isValid(_editPassword);
    bool confirmationErrorText = _submittedPassword && !_comparePasswords(_editPassword, _confirmationPassword);
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
            TextInputAction.go,
            () => _moveFocusNode(_confirmPasswordFocusNode),
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
          onPressed: _isLoading ? null : _updatePassword,
          color: const Color(0xFF000434),
        ),
      ],
    );
  }

  ///Sets the a new username for a user in firebase
  void _updateUserName() async {
    setState(() {
      _submittedUser = true;
    });
    if(widget.usernameValidator.isValid(_editUsername)) {
      _isLoading = true;
      await ref.watch(authProvider).currentUser!.updateDisplayName(_editUsername);
      _isLoading = false;
      _updateState();
    }
  }

  ///Updates the current email address with a new one
  ///throws [FirebaseAuthException] if :
  /// - the email is invalid,
  /// - the email exists,
  /// - the user is not recently authenticated,
  void _updateEmail() async {
    setState(() {
       _submittedEmail = true;
    });
    if(widget.emailValidator.isValid(_editEmail)) {
      try {
        _isLoading = true;
        await ref.watch(authProvider).currentUser!.updateEmail(_editEmail);
      } on FirebaseAuthException catch(e) {
        showAlertDialog(context,
            title: "Error",
            content: "An error occured setting a new email. "
                "Try logging in to your account again",
            defaultActionText: "Ok");
      } finally {
        _isLoading = false;
        _updateState();
      }
    }
  }

  ///Updates the current password with a new one
  ///throws [FirebaseAuthException] if :
  /// - the password is weak
  /// - the user is not recently authenticated
  void _updatePassword() async {
    setState(() {
      _submittedPassword = true;
    });
    if(widget.passwordValidator.isValid(_editPassword) && _comparePasswords(_editPassword, _confirmationPassword)) {
      try {
        _isLoading = true;
        await ref.watch(authProvider).currentUser!.updatePassword(_editPassword);
          if(!mounted) return;
          showAlertDialog(context,
              title: "Success",
              content: "Your password has been updated",
              defaultActionText: "Ok");
      } on FirebaseAuthException catch(e) {
        ///Displays an alert dialog if an error occurs
        showAlertDialog(context,
            title: "Error",
            content: "An error occured setting a new password. "
                "Try logging in to your account again",
            defaultActionText: "Ok");
      } finally{
        _isLoading = false;
        _updateState();
      }
    }
  }

  ///Compares two password inputs by the user.
  ///Returns true if the passwords match. False otherwise.
  bool _comparePasswords(String password1, String password2) {
    return password1 == password2;
  }

  ///Moves the focusnode to another textfield
  void _moveFocusNode(FocusNode newFocus) {
    FocusScope.of(context).requestFocus(newFocus);
  }

  ///Updates the state - rebuilds components
  void _updateState() {
    setState(() {});
  }
}
