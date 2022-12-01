import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/overlays/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/forms/EditUsernameForm.dart';
import '../providers/ThemeProvider.dart';

///Represents a page where user can edit their profile.
class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: makeNormalAppBar("Edit profile", context),
      body: _contentOfEditProfilePage(context, ref),
      drawer: MainMenu(),
    );
  }

  ///Builds the page
  Widget _contentOfEditProfilePage(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: <Widget>[

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
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: CustomElevatedButton(
            widget: const Text(
              "Edit name",
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            borderRadius: 4.0,
            onPressed: () {
              _showEditPage(context, EditUsernameForm());
            },
            color: const Color(0xFF000434),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: CustomElevatedButton(
            widget: const Text(
              "Edit email",
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            borderRadius: 4.0,
            onPressed: () {},
            color: const Color(0xFF000434),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: CustomElevatedButton(
            widget: const Text(
              "Change password",
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            borderRadius: 4.0,
            onPressed: () {
            },
            color: const Color(0xFF000434),
          ),
        ),
      ],
    );
  }

  ///Show the edit profile page when tapped on.
  void _showEditPage(BuildContext context, Widget pageToShow) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => pageToShow,
    ));
  }

  ///Changes the theme between light and dark mode.
  void ChangeTheme(WidgetRef ref) {
    ref.read(themeProvider.notifier).state =
        ref.watch(themeProvider) == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;
  }
}
