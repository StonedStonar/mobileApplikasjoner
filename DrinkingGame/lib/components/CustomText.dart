import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget{

  String text;

  double fontSize;

  FontWeight fontWeight;

  CustomText({required this.text, required this.fontSize, required this.fontWeight, super.key});

  @override
  Widget build(BuildContext context) {
    return buildHeadLineText();
  }

  Widget buildHeadLineText() {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}

