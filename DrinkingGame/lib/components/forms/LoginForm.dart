import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/forms/textfields/TextFields.dart';
import 'package:drinkinggame/providers/signup_login_provider.dart';
import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget with UsernamePasswordAndEmailValidators{
  LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

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

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  bool allFieldsValid() {
    if(widget.emailValidator.isValid(_email)
        && widget.passwordValidator.isValid(_password)) {
      return true;
    } else {
      return false;
    }
  }

  ///Creates and returns a widget list of the
  ///textfields for input and the submit button
  List<Widget> _buildChildren(WidgetRef ref) {
    bool emailErrorText = _submitted && !widget.emailValidator.isValid(_email);
    bool passwordErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    return [

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
          _submit),

      const SizedBox(height: 25.0),

      TextButton(onPressed: () => _switchPage(ref),
        child: Text(
        "Don't have an account?",
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    ),
      const SizedBox(height: 8.0),
      CustomElevatedButton(widget: const Text(
        "Login",
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