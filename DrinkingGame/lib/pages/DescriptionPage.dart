import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _descriptionContent(),
    );
  }

  Widget _descriptionContent() {
    return Padding(padding: const EdgeInsets.all(20.0));
  }
}