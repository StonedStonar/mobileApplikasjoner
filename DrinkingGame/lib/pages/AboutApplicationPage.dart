import 'package:drinkinggame/components/AppBars.dart';
import 'package:flutter/material.dart';
import '../components/overlays/MainMenu.dart';

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

  Widget _aboutApplicationContent() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Image.asset('images/PepeLaugh.png'),
        const Text(
          "Frequently asked questions",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold
          ),
          ),
        const SizedBox(height: 18.0),
        buildText(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean finibus, risus sit amet lacinia rutrum, magna velit egestas ante, vel egestas mi orci vel turpis."
              " Proin quis odio nec urna consectetur pellentesque. Morbi pretium leo vel varius eleifend. Maecenas cursus dictum lorem, quis suscipit mauris condimentum non."
              "Sed in neque at nisl rutrum congue vitae et magna."
        ),
      ],
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 24),
    );
  }
}
