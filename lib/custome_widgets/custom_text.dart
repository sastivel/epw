import 'package:flutter/material.dart';
import '../utils/color_resource.dart';
import '../utils/fonts.dart';


class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Font font;
  final Color color;
  final double lineHeight;
  final TextAlign textAlign;
  final GestureTapCallback? onTap;
  final isUnderLine;
  final isSingleLine;
  final int? maxLines;

  CustomText(String text,
      {this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.font = Font.urbanistMedium,
      this.color = ColorResource.BLACKE4E7EB,
      this.lineHeight = 1.21, // Line Height - 17
      this.textAlign = TextAlign.left,
      this.onTap = null,
      this.isUnderLine = false,
      this.isSingleLine = false,
      this.maxLines})
      : this.text = text;

  @override
  Widget build(BuildContext context) {
    Text textWidget = Text(text,
        textAlign: textAlign,
        overflow: isSingleLine ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
        softWrap: true,
        style: TextStyle(
            decoration:
                isUnderLine ? TextDecoration.underline : TextDecoration.none,
            color: color,
            fontFamily: font.value,
            fontWeight: fontWeight,
            overflow: isSingleLine ? TextOverflow.ellipsis : null,
            // fontSize: fontSize,
            fontSize: fontSize,
            height: lineHeight));

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: textWidget,
      );
    } else {
      return textWidget;
    }
  }
}
