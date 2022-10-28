import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/material.dart';

import '../components/AppBars.dart';

class SignUpPage extends StatefulWidget with UsernamePasswordAndEmailValidators{
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController = TextEditingController();

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  String get _username => _usernameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmationPassword => _confirmationPasswordController.text;

  bool _submitted = false;
  bool _isLoading = false;

  void _submit() {
    setState(() {
      _submitted = true;
      if(allFieldsValid()) {
        _isLoading = true;
      }
    });
  }

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


  bool allFieldsValid() {
    if(widget.usernameValidator.isValid(_username)
    && widget.emailValidator.isValid(_email)
    && widget.passwordValidator.isValid(_password)
    && _comparePasswords()) {
      return true;
    } else {
      return false;
    }
  }

  ///Creates and returns a widget list of the
  ///textfields for input and the submit button
  List<Widget> _buildChildren() {
    return [
      _buildUsernameTextField(),
      const SizedBox(height: 8.0),
      _buildEmailTextField(),
      const SizedBox(height: 8.0),
      _buildPasswordTextField(),
      const SizedBox(height: 8.0),
      _buildConfirmPasswordTextField(),
      const SizedBox(height: 25.0),
      CustomElevatedButton(widget: const Text(
        "Register User",
        style: TextStyle(fontSize: 22),
      ),
          borderRadius: 10,
          onPressed: _isLoading ? null : _submit,
          color: const Color(0xFF000434),
      )
    ];
  }

  TextField _buildUsernameTextField() {
    bool usernameErrorText = _submitted && !widget.usernameValidator.isValid(_username);
    return TextField(
        style: TextStyle(fontSize: 20),
        controller: _usernameController,
        focusNode: _userNameFocusNode,
        onChanged: (username) => _updateState(),
        decoration: InputDecoration(
          labelText: "Username",
          hintText: "Your username",
          errorText: usernameErrorText ? "Invalid username" : null,
        ),
        enabled: !_isLoading,
        autocorrect: false,
        textInputAction: TextInputAction.go,
        onEditingComplete: _usernameEditingComplete,
        key: const Key("username_input")
    );
  }

  TextField _buildEmailTextField() {
    bool emailErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
        style: TextStyle(fontSize: 20),
        controller: _emailController,
        focusNode: _emailFocusNode,
        onChanged: (_email) => _updateState(),
        decoration: InputDecoration(
            labelText: "Email",
            hintText: "Your Email Address",
            errorText: emailErrorText ? "Invalid email" : null,
        ),
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        textInputAction: TextInputAction.go,
        onEditingComplete: _emailEditingComplete,
        enabled: !_isLoading,
        key: const Key("email_input")
    );
  }

  TextField _buildPasswordTextField() {
    bool passwordErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
        style: TextStyle(fontSize: 20),
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        onChanged: (_password) => _updateState(),
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Your Password",
          errorText: passwordErrorText ? "4-20 chars, uppercase, lowercase, digits" : null,
        ),
        enabled: !_isLoading,
        autocorrect: false,
        textInputAction: TextInputAction.go,
        onEditingComplete: _passwordEditingComplete,
        obscureText: true,
        key: const Key("password_input")
    );
  }

  TextField _buildConfirmPasswordTextField() {
    bool confirmationErrorText = _submitted && !_comparePasswords();
    return TextField(
        style: TextStyle(fontSize: 20),
        controller: _confirmationPasswordController,
        focusNode: _confirmPasswordFocusNode,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Rewrite your password",
          errorText: confirmationErrorText ? "passwords do not match" : null,
        ),
        enabled: !_isLoading,
        autocorrect: false,
        textInputAction: TextInputAction.done,
        onEditingComplete: _submit,
        obscureText: true,
        key: const Key("confirmPassword_input")
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeNormalAppBar("Register user", context),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildChildren(),
              )
          )
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
}