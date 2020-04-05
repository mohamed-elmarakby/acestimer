import 'package:flutter/material.dart';

class RizmeButton extends StatelessWidget {
  //\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ variables
  final String text;
  final TextStyle style;
  final Icon icon;
  final Color backColor, splashColor;
  final double borderRadius, elevation, height, width;
  final EdgeInsets padding;
  final Function onPressed;
  Widget button;
  //\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ variables

  //\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ constructor
  RizmeButton(
      {this.height,
      this.width,
      this.icon,
      @required this.text,
      this.style = const TextStyle(
          color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
      this.backColor = Colors.red,
      this.splashColor = Colors.blueAccent,
      this.borderRadius,
      this.elevation = 0.0,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      @required this.onPressed});
  //\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ constructor

  @override
  Widget build(BuildContext context) {
    Widget buildButton() {
      //\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ Function

      if (icon == null) {
        return button = FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Text(text, style: style),
          padding: padding,
          splashColor: splashColor,
          onPressed: onPressed,
        );
      } else {
        return button = FlatButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          label: Text(text, style: style),
          padding: padding,
          icon: icon,
          splashColor: splashColor,
          onPressed: onPressed,
        );
      }
      //\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ Function
    }

    return Material(
      elevation: elevation,
      color: backColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(width: width, height: height, child: buildButton()),
    );
  }
}
