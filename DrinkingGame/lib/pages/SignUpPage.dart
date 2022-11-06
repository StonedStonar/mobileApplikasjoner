import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/forms/LoginForm.dart';
import 'package:drinkinggame/components/forms/SignUpForm.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeBasicAppbar("Register user"),
      body: SingleChildScrollView(
          child: LoginForm(),
      )
    );
  }
}