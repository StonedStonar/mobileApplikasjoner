import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:drinkinggame/components/overlays/MainMenu.dart';
import 'package:flutter/material.dart';
import '../components/overlays/SideMenu.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeNormalAppBar("Settings", context),
      body: _contentOfSettingsPage(),
      drawer: MainMenu(),
    );
  }

  Widget _contentOfSettingsPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
          child: CustomElevatedButton(
            widget: const Text(
              "Change language",
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
              "Change to darkmode",
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
}
