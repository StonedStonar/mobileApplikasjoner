import 'package:flutter/material.dart';

import 'CustomElevatedButton.dart';

class SignInButton extends CustomElevatedButton {

  /// Makes an instance of the sign in button
  /// [text] the text of the button
  /// [backgroundColor] the background color.
  /// [textColor] the text color.
  /// [onPressed] the on pressed function.
  SignInButton(
      {required String text,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black,
      required VoidCallback onPressed,
      Key? key})
      : super(
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          borderRadius: 4,
          onPressed: onPressed,
          color: backgroundColor,
          height: 80,
          key: key,
        );
}
