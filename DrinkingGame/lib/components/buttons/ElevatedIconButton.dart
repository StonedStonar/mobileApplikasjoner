import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Represents a elevated icon buttton.
class ElevatedIconButton extends StatelessWidget {

  ///Makes an instance of the ElevatedIconButton
  ///[iconSize] the size of the icon.
  ///[iconData] the type of icon.
  ///[onPressed] the function the icon should have.
  ElevatedIconButton({Key? key, this.iconSize = 24, required this.iconData, required this.onPressed}) : super(key: key);

  double iconSize;

  IconData iconData;

  Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: Icon(
        iconData,
        size: iconSize,
      ),
    );
  }
}
