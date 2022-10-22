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

  String get _username => _usernameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmationPassword => _confirmationPasswordController.text;


  bool _submitted = false;
  ///TODO: implement functionality
  /// - Check if password and confirmationpassword are matching
  void _submit() {
    setState(() {
      _submitted = true;
    });
  }

  ///Creates and returns a widget list of the
  ///textfields for input and the submit button
  List<Widget> _buildChildren() {
    return [
      _buildUsernameTextField(),
      SizedBox(height: 8.0),
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      _buildConfirmPasswordTextField(),
      SizedBox(height: 25.0),
      CustomElevatedButton(widget: Text(
        "Register User",
        style: TextStyle(fontSize: 22),
      ), borderRadius: 10, onPressed: _submit, color: Color(0xFF000434))
    ];
  }

  TextField _buildUsernameTextField() {
    bool usernameErrorText = widget.usernameValidator.isValid(_username);
    return TextField(
        style: TextStyle(fontSize: 20),
        controller: _usernameController,
        onChanged: (username) => _updateState(),
        decoration: InputDecoration(
          labelText: "Username",
          hintText: "Your username",
          errorText: usernameErrorText ? null : "Invalid username",
        ),
        key: Key("username_input")
    );
  }

  TextField _buildEmailTextField() {
    bool emailErrorText = widget.emailValidator.isValid(_email);
    return TextField(
        style: TextStyle(fontSize: 20),
        controller: _emailController,
        onChanged: (_email) => _updateState(),
        decoration: InputDecoration(
            labelText: "Email",
            hintText: "Your Email Address",
            errorText: emailErrorText ? null : "Invalid email"
        ),
        keyboardType: TextInputType.emailAddress,
        key: Key("email_input")
    );
  }

  TextField _buildPasswordTextField() {
    bool passwordErrorText = widget.passwordValidator.isValid(_password);
    return TextField(
        style: TextStyle(fontSize: 20),
        controller: _passwordController,
        onChanged: (_password) => _updateState(),
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Your Password",
          errorText: passwordErrorText ? null : "4-20 chars, uppercase, lowercase, digits",
        ),
        key: Key("password_input")
    );
  }

  TextField _buildConfirmPasswordTextField() {
    return TextField(
        style: TextStyle(fontSize: 20),
        controller: _confirmationPasswordController,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Rewrite your password",
        ),
        key: Key("confirmPassword_input")
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