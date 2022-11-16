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

class ProfilePage extends ConsumerWidget{


  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(username),
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
            //onPressed: () => _showEditProfilePage(context),
              onPressed: () {},
            color: const Color(0xFF000434)
          ),
        ),
        Padding(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
        child: CustomElevatedButton(
            widget: Text(
              "Change password",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            borderRadius: 4,
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

void main () {
  runApp(ProviderScope(child: ProfilePage()));
}