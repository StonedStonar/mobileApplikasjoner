import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  /// Makes an instance of the custom elevated button.
  /// [widget] is the content of the button.
  /// [borderRadius] is the radius the edges should have.
  /// [onPressed] the function of the button.
  /// [height] the height of the button.
  CustomElevatedButton(
      {required this.widget, required this.onPressed, this.height = 50, this.color, Key? key})
      : super(key: key);

  final Widget widget;
  final VoidCallback? onPressed;
  final double height;
  Color? color;

  @override
  Widget build(BuildContext context) {
    late ButtonStyle buttonStyle = ButtonStyle();
    if(color != null){
      buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => color!),
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 2.5, 10, 2.5),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: onPressed,
          child: widget,
        ),
      ),
    );
  }
}
