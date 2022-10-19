import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:flutter/material.dart';

class GameButton extends CustomElevatedButton {

  GameButton({required String text, required String subtext, Color textColor = Colors.black, Color secondTextColor = Colors.black54,
    required VoidCallback onPressed, Key? key})
      : super(
        widget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtext,
                style: TextStyle(
                  color: secondTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        borderRadius:8.0,
        onPressed: onPressed,
        color: const Color(0xFFD9D9D9),
        height: 70,
        key: key,
  );
}
