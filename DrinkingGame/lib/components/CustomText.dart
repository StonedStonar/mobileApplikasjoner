import 'dart:ui';

import 'package:flutter/cupertino.dart';

Widget buildHeadLineText(String text, double fontSize, FontWeight fontWeight) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
  );
}