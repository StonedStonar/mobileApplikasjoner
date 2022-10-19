import 'package:drinkinggame/components/AppBars.dart';
import 'package:flutter/material.dart';

import '../components/overlays/SideMenu.dart';

class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeNormalAppBar("About application", context),
      body: _aboutApplicationContent(),
      drawer: SideMenu(),
    );
  }

  Widget _aboutApplicationContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Title(
            color: Colors.black,
            child: Text(
                "Frequently asked questions:",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
            ),
          ),
          Text("\nMate if you wound your way here during the demo then you have found"
              "the one and only easteregg in this prototype.\n\n"
              "What is drowned and orange but can breathe under water?\n"
              "\nA drowned lobster in a fresh water lake.\n"
              "\nOsmose 101\n"
              "\nAnd before you say “IMPOSSIBLE” it is possible. Since the salt content of a saltwater fish is higher it drowns in freshwater since the water outside the fish wants to balance the amount of salt in the fish. "
              "This ends in the lobster absorbing alot of water and dies beacuse of it",
          style: TextStyle(
            fontSize: 20,
          ),
          ),
        ],
      ),
    );
  }
}
