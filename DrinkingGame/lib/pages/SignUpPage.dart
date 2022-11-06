import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/forms/LoginForm.dart';
import 'package:drinkinggame/components/forms/SignUpForm.dart';
import 'package:drinkinggame/providers/signup_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayLoginOrSignUpPage = ref.watch(signUpOrLoginProvider);
    return Scaffold(
      appBar: makeBasicAppbar(displayLoginOrSignUpPage ? "Login" : "Register user"),
      body: SingleChildScrollView(
          child: displayLoginOrSignUpPage ? LoginForm() : SignUpForm(),
      )
    );
  }
}