import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget{

  ///Makes an instance of the menu button.
  ///[buttonText] the text of the button
  ///[icon] the icon of the button.
  ///[onPressed] the function to execute.
  ///[spaceBetween] the space between the logo and the text.
  ///[size] the size of the text and icon.
  MenuButton({required this.buttonText, required this.icon, required this.onPressed, this.spaceBetween = 15, this.size = 20,  super.key});

  String buttonText;

  IconData icon;


  double spaceBetween;

  VoidCallback onPressed;

  double size;


  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Icon(
                icon,
                size: size*1.5,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(spaceBetween, 0, 0, 0),
                child: Text(
                  buttonText,
                  style: TextStyle(
                      fontSize: size
                  ),
                ),
              )
            ],
          ),
        )
    );
  }


}