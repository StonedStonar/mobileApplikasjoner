import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/overlays/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/forms/EditProfileForm.dart';
import '../providers/ThemeProvider.dart';

///Represents a page where user can edit their profile.
class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: makeNormalAppBar("Edit profile", context),
      body: EditProfileForm(),
      drawer: MainMenu(),
    );
  }

  ///Changes the theme between light and dark mode.
  void ChangeTheme(WidgetRef ref) {
    ref.read(themeProvider.notifier).state =
        ref.watch(themeProvider) == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;
  }
}
