import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/overlays/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: makeNormalAppBar("Edit profile", context),
      body: _contentOfSettingsPage(ref),
      drawer: MainMenu(),
    );
  }

  Widget _contentOfSettingsPage(WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
          child: CustomElevatedButton(
            widget: const Text(
              "Edit name",
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
            onPressed: () {},
            color: const Color(0xFF000434),
          ),
        ),
      ],
    );
  }

  void ChangeTheme(WidgetRef ref) {
    ref.read(themeProvider.notifier).state = ref.watch(themeProvider) == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}
