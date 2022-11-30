import 'package:drinkinggame/components/AppBars.dart';
import 'package:flutter/material.dart';
import '../../components/overlays/MainMenu.dart';

class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeNormalAppBar("About application", context),
      body: _aboutApplicationContent(),
      drawer: MainMenu(),
    );
  }

  ///Builds the content for the page.
  ///Return the widget _aboutApplicationContent.
  Widget _aboutApplicationContent() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Image(
          image: AssetImage('images/PepeLaugh.png'),
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16.0),
        const Text(
          "The Drinking game app",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold
          ),
          ),
        const SizedBox(height: 16.0),
        buildText(
          "This is an mobile app developed by an group of 4 norwegian students."
              "The main goal with this project is for the students to learn many aspects of creating a "
              "mobile application form start to finish. We have used 5 months to develop this app, hope you like it! "
        ),
      ],
    );
  }

  ///Used to change the text for about application description.
  ///The title will not be altered here, only main description.
  Widget buildText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
    );
  }
}
