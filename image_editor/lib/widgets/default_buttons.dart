import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
      required this.color,
      required this.child,
      required this.textColor,
      required this.onPress});
  final Color color;
  final Widget child;
  final Color textColor;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(color: textColor))),
      child: child,
    );
  }
}
