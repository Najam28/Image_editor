import 'package:flutter/cupertino.dart';
import 'package:image_editor/models/text_info.dart';

class ImageText extends StatelessWidget {
  const ImageText({super.key, required this.textInfo});
  final TextInfo textInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: TextStyle(
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        color: textInfo.color,
        fontStyle: textInfo.fontstyle,
      ),
    );
  }
}
