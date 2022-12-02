import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/SignInButton.dart';
import 'package:drinkinggame/components/buttons/SocialSignInButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/Dialogs.dart';
import '../../providers/AuthProvider.dart';
import '../../services/auth/Authentication.dart';
import 'SignUpPage.dart';

///Represents a login page.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  bool _isLoading = false;

  Drawer? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeLoginAppBar(),
      body: makePageContent(context),
    );
  }

  ///Opens the drawer.
  void openDrawer(BuildContext context){
    Scaffold.of(context).openDrawer();
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
        const Padding(
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

  ///Logs the user in with google.
  ///[context] the build context
  void _loginWithGoogle(BuildContext context) async {
    Authentication authentication = ref.watch(authProvider);
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

  ///Logs the user in with email
  ///[context] the build context
  void _loginWithEmail(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignUpPage())
    );
  }

  ///Logs the user in with email
  ///[context] the build context
  void _loginWithEmail2(BuildContext context) async {
    Authentication authentication = ref.watch(authProvider);
    try {
      _isLoading = true;
    } on Exception catch (e) {
      print(e.toString());
    } finally {
      _setLoadingState(false);
    }
  }

  ///Logs the user into an anonymous account
  ///[context] the build context
  void _loginWithAnonymous(BuildContext context) async {
    Authentication authentication = ref.watch(authProvider);
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
