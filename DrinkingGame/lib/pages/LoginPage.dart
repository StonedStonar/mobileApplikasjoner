import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/SignInButton.dart';
import 'package:drinkinggame/components/buttons/SocialSignInButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/Dialogs.dart';
import '../services/Authentication.dart';

///Represents a login page.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeLoginAppBar(),
      backgroundColor: Colors.grey.shade100,
      body: makePageContent(context),
    );
  }

  ///Makes the main content of the page.
  /// [context] the build context
  Widget makePageContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SocialSignInButton(
            assetName: "images/google-logo.png",
            text: "Login with google",
            onPressed: () => _isLoading ? null : _loginWithGoogle(context)),
        SignInButton(
            text: "Sign in with email",
            onPressed: () => _isLoading ? null : _loginWithEmail(context)),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            "Don't want to login?",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        SignInButton(
            text: "Go anonyomous",
            onPressed: () => _isLoading ? null : _loginWithAnonymous(context)),
      ],
    );
  }

  void _loginWithGoogle(BuildContext context) async {
    Authentication authentication = Provider.of<Authentication>(context, listen: false);
    try {
      _setLoadingState(true);
      await authentication.signInToGoogle();
      //print("${userCredentials.user?.uid}");
    } on Exception catch (e) {
      _showSignInError(context, e);
    }finally{
      _setLoadingState(false);
    }
  }

  void _loginWithEmail(BuildContext context) async {
    Authentication authentication = Provider.of<Authentication>(context, listen: false);
    try {
      _isLoading = true;
    } on Exception catch (e) {
      print(e.toString());
    } finally {
      _setLoadingState(false);
    }
  }

  void _loginWithAnonymous(BuildContext context) async {
    Authentication authentication = Provider.of<Authentication>(context, listen: false);
    try {
      _isLoading = true;
      authentication.signInAnonymously();
    } on Exception catch (e) {
      print(e.toString());
    } finally {
      _setLoadingState(false);
    }
  }

  ///Shows a sign in error.
  ///[context] the build context
  ///[exception] the exception.
  void _showSignInError(BuildContext context, Exception exception){
    showExceptionAlertDialog(context, title: "Sign in failed", exception: exception);
  }

  ///Sets the loading state to a new value.
  ///[loadingState] the new loading state.
  void _setLoadingState(bool loadingState) {
    setState(() => _isLoading = loadingState);
  }
}
