import 'package:flutter/cupertino.dart';

class TextInfo {
  String text;
  double left;
  double top;
  Color color;
  FontWeight fontWeight;
  FontStyle fontstyle;
  double fontSize;
  TextAlign textAlign;

  TextInfo({
    required this.text,
    required this.left,
    required this.top,
    required this.color,
    required this.fontWeight,
    required this.fontstyle,
    required this.fontSize,
    required this.textAlign,
  });
}
