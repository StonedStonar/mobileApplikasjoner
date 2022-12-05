
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
import '../../components/CustomText.dart';
import '../../components/InfoGameCard.dart';
import '../../providers/AuthProvider.dart';
import '../../providers/ThemeProvider.dart';

///Page to show a user profile
class ProfilePage extends ConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final user = UserPreferences.myUser;
    return Scaffold(
      appBar: makeNormalAppBar("Profile", context),
      body: Center(
        child: SingleChildScrollView(
          child: _buildContent(context, ref),
        ),
      ),
      drawer: MainMenu(),
    );
  }

  ///Builds the content of the page
  ///[widgetRef] the widget ref.
  ///Returns the widget.
  Widget _buildContent(BuildContext context, WidgetRef ref){
    Authentication? authentication = ref.watch(authProvider);
    String username = authentication?.currentUser?.displayName == null ? "No username" : authentication!.currentUser!.displayName!;
    String email = authentication?.currentUser?.email == null ? "No email" : authentication!.currentUser!.email!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        ///Display the page according to if the user is anonymous or not
        authentication?.currentUser?.isAnonymous != true
            ? _buildLoggedInUserWidget(context, username, email)
            : _buildAnonymousWidget(),

        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 15),
          child: CustomElevatedButton(
            widget: Text(
              "Change to darkmode",
            ),
            onPressed: () => ChangeTheme(ref),
          ),
        ),
      ],
    );
  }

  ///Widget for displaying user attributes
  ///BuildContext [context] context of the page
  ///String [username] the username of the user
  ///String [email] the email of the user
  Widget _buildLoggedInUserWidget(BuildContext context, String username, String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(50, 10, 50, 15),
          child: Image.asset(
            'images/default_user_icon.png',
            width: 300,
            height: 150,
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
            ),
            onPressed: () => _showEditProfilePage(context),
          ),
        ),
      ],
    );
  }

  ///Widget for informing the user is anonymously logged in
  Widget _buildAnonymousWidget() {
    return Padding(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 25),
        child: Align(
          alignment: Alignment.center,
          child: CustomText(
          text: "You are not logged in",
          fontSize: 20,
          fontWeight: FontWeight.w400),
        ),
    );
  }

  /// Changes to darkmode when tapped.
  void ChangeTheme(WidgetRef ref) {
    ref.read(themeProvider.notifier).state = ref.watch(themeProvider) == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  ///Show the edit profile page when tapped on.
  void _showEditProfilePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditProfilePage(),
    ));
  }

}
