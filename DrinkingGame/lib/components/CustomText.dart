import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget{

  String text;

  double fontSize;

  FontWeight fontWeight;

  ///Makes an instance of custom texxt
  ///[text] the text to show
  ///[fontSize] the font size
  ///[fontWeight] the font weight
  ///[key] the key.
  CustomText({required this.text, required this.fontSize, required this.fontWeight, super.key});

  @override
  Widget build(BuildContext context) {
    return buildHeadLineText();
  }

  ///Builds the headline text
  ///Returns the headline text
  Widget buildHeadLineText() {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}

