import 'package:drinkinggame/providers/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Represents a elevated icon buttton.
class ElevatedIconButton extends ConsumerWidget {

  ///Makes an instance of the ElevatedIconButton
  ///[iconSize] the size of the icon.
  ///[iconData] the type of icon.
  ///[onPressed] the function the icon should have.
  ElevatedIconButton({Key? key, this.iconSize = 30, required this.iconData, required this.onPressed}) : super(key: key);

  double iconSize;

  IconData iconData;

  Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => onPressed(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white.withOpacity(0)),
        foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
      ),
      child: Icon(
        iconData,
        size: iconSize,
      ),
    );
  }
}
