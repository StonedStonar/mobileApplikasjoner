import 'package:drinkinggame/components/AppBars.dart';
import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:flutter/material.dart';

enum MenuItem {firstItem, secondItem, thirdItem}

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gamePageAppBar(context),
      body: _contentOfGamePage(context),
    );
  }

  Widget _contentOfGamePage(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16.0),
        CustomElevatedButton(
          widget: const ListTile(
            title: Text(
              "Never have i ever",
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            subtitle: Text(
              "Players 1-100",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54
              ),
            ),
          ),
          onPressed: () {},
          borderRadius: 8.0,
          color: Color(0xFFD9D9D9),
          height: 70.0,
        ),
        const SizedBox(height: 16.0),
        CustomElevatedButton(
          widget: const ListTile(
            title: Text(
              "Ring of Fire rules",
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            subtitle: Text(
              "Only rules",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54
              ),
            ),
          ),
          onPressed: () {},
          borderRadius: 8.0,
          color: Color(0xFFD9D9D9),
          height: 70.0,
        ),
        const SizedBox(height: 16.0),
        CustomElevatedButton(
          widget: const ListTile(
            title: Text(
              "Truth or dare",
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            subtitle: Text(
              "Players 1-10",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54
              ),
            ),
          ),
          onPressed: () {},
          borderRadius: 8.0,
          color: Color(0xFFD9D9D9),
          height: 70.0,
        ),
      ],
    );
  }
}
