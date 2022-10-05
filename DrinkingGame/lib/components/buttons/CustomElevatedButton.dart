import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  /// Makes an instance of the custom elevated button.
  /// [widget] is the content of the button.
  /// [borderRadius] is the radius the edges should have.
  /// [function] the function of the button.
  /// [color] the color of the button.
  /// [height] the height of the button.
  CustomElevatedButton(
      this.widget, this.borderRadius, this.function, this.color, {this.height = 60, Key? key})
      : super(key: key);

  final Widget widget;
  final double borderRadius;
  final VoidCallback? function;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 2.5, 10, 2.5),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)))),
            backgroundColor: MaterialStateColor.resolveWith((states) => color),
          ),
          onPressed: function,
          child: widget,
        ),
      ),
    );
  }
}
