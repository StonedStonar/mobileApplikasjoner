import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/SignInButton.dart';
import 'package:drinkinggame/components/buttons/SocialSignInButton.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{

  const LoginPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeLoginAppBar(),
      body: makePageContent(context),
    );
  }

  Widget makePageContent(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SocialSignInButton(assetName: "images/google-logo.png", text: "Login with google", onPressed: () => _loginWithGoogle(context)),
        SignInButton(text: "Sign in with email", onPressed: () => _loginWithEmail(context)),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
                "Don't want to login?",
                style: TextStyle(
                    fontSize: 20,
                ),
            ),
        ),
        SignInButton(text: "Go anonyomous", onPressed: () => _loginWithAnonymous(context)),


      ],
    );
  }
  
  void _loginWithGoogle(BuildContext context){
    
  }
  
  void _loginWithEmail(BuildContext context){
    
  }
  
  void _loginWithAnonymous(BuildContext context){
    
  }
  
}