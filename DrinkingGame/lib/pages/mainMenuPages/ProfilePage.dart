
import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/forms/AuthenticationForm.dart';
import 'package:drinkinggame/components/overlays/MainMenu.dart';
import 'package:drinkinggame/pages/EditProfilePage.dart';
import 'package:drinkinggame/services/auth/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/AppBars.dart';
import '../../components/InfoGameCard.dart';
import '../../providers/AuthProvider.dart';

class ProfilePage extends ConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final user = UserPreferences.myUser;
    return Scaffold(
      appBar: makeNormalAppBar("Profile", context),
      body: _buildContent(ref),
      drawer: MainMenu(),
    );
  }

  ///Builds the content of the page
  ///[widgetRef] the widget ref.
  ///Returns the widget.
  Widget _buildContent(WidgetRef widgetRef){
    Authentication? authentication = widgetRef.watch(authProvider);
    String username = authentication?.currentUser?.displayName == null ? "No username" : authentication!.currentUser!.displayName!;
    String email = authentication?.currentUser?.displayName == null ? "No email" : authentication!.currentUser!.email!;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(50, 20, 50, 15),
          child: Image.asset(
              'images/face.jpg',
            width: 400,
            height: 200,
            fit: BoxFit.contain,
          ),

        ),
        Padding(
          padding: EdgeInsets.fromLTRB(50, 20, 50, 15),
          child: Text(
              "Your username: $username",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(50, 20, 50, 15),
          child: Text(
            "Your email: $email",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(50, 20, 50, 15),
          child: CustomElevatedButton(
            widget: Text(
              "Edit profile",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            borderRadius: 4,
            //onPressed: (context) => {_showEditProfilePage(context),},
              onPressed: () {},
            color: const Color(0xFF000434)
          ),
        ),
      ],
    );
  }

  void _showEditProfilePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const EditProfilePage(),
    ));
  }

}
