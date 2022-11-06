import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/services/Authentication.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/signup_login_provider.dart';
import '../AppBars.dart';

class SignUpForm extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators{
  SignUpForm({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {

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
  List<Widget> _buildChildren(WidgetRef ref) {
    bool usernameErrorText = _submitted && !widget.usernameValidator.isValid(_username);
    bool emailErrorText = _submitted && !widget.emailValidator.isValid(_email);
    bool passwordErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    bool confirmationErrorText = _submitted && !_comparePasswords();
    return [
      buildUsernameTextField(_usernameController,
                             _userNameFocusNode,
                             _updateState,
                             usernameErrorText,
                             _isLoading,
                             _usernameEditingComplete),

      const SizedBox(height: 8.0),
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
                             _passwordEditingComplete),

      const SizedBox(height: 8.0),
      buildConfirmPasswordTextField(_confirmationPasswordController,
                                    _confirmPasswordFocusNode,
                                    _updateState,
                                    confirmationErrorText,
                                    _isLoading,
                                    _submit),
      const SizedBox(height: 25.0),

      TextButton(onPressed: () => _switchPage(ref), child: Text(
        "Already have an account?",
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      ),
      const SizedBox(height: 8.0),
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

  bool _switchPage(WidgetRef ref) {
    return ref.read(signUpOrLoginProvider.notifier).state = !ref.read(signUpOrLoginProvider.notifier).state;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildChildren(ref),
              )
    );
  }

  void _updateState() {
    setState(() {});
  }
}