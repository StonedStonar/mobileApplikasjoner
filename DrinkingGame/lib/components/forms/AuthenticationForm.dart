import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:drinkinggame/services/database/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../App.dart';
import '../../providers/signup_login_provider.dart';
import '../../services/auth/Authentication.dart';
import '../AppBars.dart';

///A form for authenticating the user, by either login or signup.
class AuthenticationForm extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators{
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

  ///Creates and returns a widget list of the
  ///textfields for input and the submit button
  List<Widget> _buildChildren() {
    bool usernameErrorText = _submitted && !widget.usernameValidator.isValid(_username);
    bool emailErrorText = _submitted && !widget.emailValidator.isValid(_email);
    bool passwordErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    bool confirmationErrorText = _submitted && !_comparePasswords();
    return [
      if (_register) buildUsernameTextField(_usernameController,
          _userNameFocusNode,
          _updateState,
          usernameErrorText,
          _isLoading,
          _usernameEditingComplete),
      if(_register)const SizedBox(height: 8.0),

      buildEmailTextField(_emailController,
          _emailFocusNode,
          _updateState,
          emailErrorText,
          _isLoading,
          _emailEditingComplete),
      const SizedBox(height: 8.0),

      buildPasswordTextField(_passwordController,
          _passwordFocusNode,
          _updateState,
          passwordErrorText,
          _isLoading,
          !_register ? TextInputAction.done : TextInputAction.go,
          !_register ? _submit : _passwordEditingComplete),
      const SizedBox(height: 8.0),

     if (_register) buildConfirmPasswordTextField(_confirmationPasswordController,
          _confirmPasswordFocusNode,
          _updateState,
          confirmationErrorText,
          _isLoading,
          _register ? TextInputAction.done : TextInputAction.go,
          _submit),
      if(_register) const SizedBox(height: 25.0),

      TextButton(onPressed: _isLoading ? null : () => _switchPage(),
        child: Text(
        _register ?  "Already have an account?" : "Don't have an account?",
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
      ),
      const SizedBox(height: 8.0),
      CustomElevatedButton(widget: Text(
        _register ? "Register User" : "Login",
        style: TextStyle(fontSize: 22),
      ),
        borderRadius: 10,
        onPressed: _isLoading ? null : _submit,
        color: const Color(0xFF000434),
      )
    ];
  }

  ///Switches between login and signup page
  void _switchPage() {
     _register = !_register;
     _updateState();
  }

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

///Submits the form
  void _submit() {
    setState(() {
      _submitted = true;
    });
    _performAuthentication();
  }

  ///Authenticates the user
  void _performAuthentication() async {
    if(_register ? validateSignupInfo() : validateLoginInfo()) {
      setState(() {
        _isLoading = true;
      });
      try {
        Authentication authentication = ref.watch(authProvider);
        _register ? await authentication.createUserWithEmailAndPassword(_email, _password)
                  : await authentication.signInWithEmailAndPassword(_email, _password);
        _onSuccessfulAuth();
      } on FirebaseAuthException catch(e) {
        print(e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  ///Compares the two passwords input by the user
  bool _comparePasswords() {
    if(_password == _confirmationPassword) {
      return true;
    } else {
      return false;
    }
  }

  void _usernameEditingComplete() {
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _passwordEditingComplete() {
    FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
  }

  void _onSuccessfulAuth() {
    Navigator.of(context).pop();
    ref.watch(authProvider).currentUser!.updateDisplayName(_username);
  }

  bool validateLoginInfo() {
    if(widget.emailValidator.isValid(_email)
        && widget.passwordValidator.isValid(_password)) {
      return true;
    } else {
      return false;
    }
  }

  bool validateSignupInfo() {
    if(widget.usernameValidator.isValid(_username)
        && widget.emailValidator.isValid(_email)
        && widget.passwordValidator.isValid(_password)
        && _comparePasswords()) {
      return true;
    } else {
      return false;
    }
  }

  void _updateState() {
    setState(() {});
  }
}