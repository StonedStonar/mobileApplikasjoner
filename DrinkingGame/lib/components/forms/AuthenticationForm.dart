import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:drinkinggame/services/database/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../App.dart';
import '../../providers/AuthProvider.dart';
import '../../services/auth/Authentication.dart';
import '../AppBars.dart';
import '../Dialogs.dart';

///A form for authenticating the user, by either login or signup.
class AuthenticationForm extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators{
  ///Makes an instance of the authentication form
  ///[key] the key
  AuthenticationForm({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends ConsumerState<AuthenticationForm> {

  ///TexteditingControllers for getting user input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController = TextEditingController();

  ///Focusnodes for textfields
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  ///Simplified getters for the user input
  String get _username => _usernameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmationPassword => _confirmationPasswordController.text;

  ///True when the user has clicked submit atleast once
  bool _submitted = false;

  ///True when the application is loading
  bool _isLoading = false;

  ///Used to display the Login or Sign up page
  ///true for Sign up, false for login
  bool _register = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: makeBasicAppbar(_register ? "Register" : "Login"),

      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildChildren(),
            )
        ),
      ),
    );
  }

  ///Creates and returns a widget list of the
  ///textfields for input, button for switching between login and signup,
  ///and the submit button.
  ///Returns a list with its contents
  List<Widget> _buildChildren() {
    bool usernameErrorText = _submitted && !widget.usernameValidator.isValid(_username);
    bool emailErrorText = _submitted && !widget.emailValidator.isValid(_email);
    bool passwordErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    bool confirmationErrorText = _submitted && !_comparePasswords(_password, _confirmationPassword);
    return [
      ///Username textfield, only for signup
      if (_register) buildUsernameTextField(_usernameController,
          _userNameFocusNode,
          _updateState,
          "Username",
          "Your username",
          usernameErrorText,
          _isLoading,
          () => _moveFocusNode(_emailFocusNode),
          "username_input"),
      if(_register)const SizedBox(height: 8.0),

      ///Email textfield, for both pages
      buildEmailTextField(_emailController,
          _emailFocusNode,
          _updateState,
          "Email",
          "Your email",
          emailErrorText,
          _isLoading,
              () => _moveFocusNode(_passwordFocusNode),
          "email_input"),
      const SizedBox(height: 8.0),

      ///Passowrd textfield, for both pages
      buildPasswordTextField(_passwordController,
          _passwordFocusNode,
          _updateState,
          "Password",
          "Your password",
          passwordErrorText,
          _isLoading,
          !_register ? TextInputAction.done : TextInputAction.go,
          !_register ? _submit :  () => _moveFocusNode(_confirmPasswordFocusNode),
          "password_input"),
      const SizedBox(height: 8.0),

      ///Confirm password textfield, only for signup
     if (_register) buildConfirmPasswordTextField(_confirmationPasswordController,
          _confirmPasswordFocusNode,
          _updateState,
          "Confirm password",
          "Rewrite your password",
          confirmationErrorText,
          _isLoading,
          _register ? TextInputAction.done : TextInputAction.go,
          _submit,
          "confirmPassword_input"),
      if(_register) const SizedBox(height: 25.0),

      ///Button to switch between login and signup page
      TextButton(onPressed: _isLoading ? null : () => _switchPage(),
        child: Text(
        _register ?  "Already have an account?" : "Don't have an account?",
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
      ),
      const SizedBox(height: 8.0),

      ///Submit form button
      CustomElevatedButton(widget: Text(
        _register ? "Register User" : "Login",
        style: TextStyle(fontSize: 22),
      ),
        onPressed: _isLoading ? null : _submit,
      )
    ];
  }

  ///Switches between login and signup page
  void _switchPage() {
     _register = !_register;
     _updateState();
  }

///Submits the form for authentication
  void _submit() {
    setState(() {
      _submitted = true;
    });
    _performAuthentication();
  }

  ///Authenticates the user,
  ///Throws [FirebaseAuthException] if the user does not exist, or an error
  ///occurs while authenticating the user with firebase.
  void _performAuthentication() async {
    if(_register ? validateSignupInfo() : validateLoginInfo()) {
      setState(() {
        ///Start authentication, app is loading while waiting for firebase.
        _isLoading = true;
      });
      try {
        Authentication authentication = ref.watch(authProvider);
        ///If on the login page, login the user, sign up if on signup page.
        _register ? await authentication.createUserWithEmailAndPassword(_email, _password)
                  : await authentication.signInWithEmailAndPassword(_email, _password);
        _onSuccessfulAuth();
      } on FirebaseAuthException catch(e) {
        ///Displays an alert dialog if an error occurs
        showAlertDialog(context,
            title: "Error",
            content: "An error occured, make sure your credentials are correct,"
                " and try again.",
            defaultActionText: "Ok");
      } finally {
        setState(() {
          ///Authentication is finished, thus not loading anymore.
          _isLoading = false;
        });
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

  ///Exits the authentication page on successful authentication
  void _onSuccessfulAuth() {
    if(_register){
      ref.watch(authProvider).currentUser!.updateDisplayName(_username);
    }
    Navigator.of(context).pop();
  }

  ///Checks if the email and password fields in the login form
  ///are valid according to business logic
  ///Returns true if the email and password is valid. False otherwise.
  bool validateLoginInfo() {
    return widget.emailValidator.isValid(_email)
        && widget.passwordValidator.isValid(_password);
  }

  ///Checks if the username, email and password fields in the
  ///sign up form are valid according to business logic
  ///Returns true if the username, email and password is valid. False otherwise.
  bool validateSignupInfo() {
    return widget.usernameValidator.isValid(_username)
        && widget.emailValidator.isValid(_email)
        && widget.passwordValidator.isValid(_password)
        && _comparePasswords(_password, _confirmationPassword);
  }

  ///Updates the state - rebuilds components
  void _updateState() {
    setState(() {});
  }
}