import 'package:flutter/material.dart';

import 'CustomElevatedButton.dart';

class SocialSignInButton extends CustomElevatedButton {

  /// Makes an instance of the sign in button
  /// [assetName] the file path to the image.
  /// [text] the text of the button
  /// [onPressed] the function of the button.
  /// [color] the background color of the button
  /// [textColor] the text color.
  /// [iconHeight] the height of the icon.
  SocialSignInButton(
      {required String assetName,
      required String text,
      required VoidCallback onPressed,
      Key? key,
      Color color = Colors.white,
      Color textColor = Colors.black,
      double? iconHeight = 40})
      : super(
            key: key,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(assetName, height: iconHeight),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: iconHeight,
                )
              ],
            ),
            borderRadius: 4,
            onPressed: onPressed,
            color: color,
            height: 80);
}
