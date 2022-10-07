// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:

class MyText extends StatelessWidget {
  final String data;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final bool haveShadow;
  final String? fontFamily;
  final TextDirection? textDirection;
  final Paint? foreground;
  final double? wordSpacing;

  MyText(
      this.data, {
        Key? key,
        this.fontSize,
        this.color,
        this.fontWeight,
        this.letterSpacing,
        this.overflow,
        this.maxLines,
        this.height,
        this.textAlign,
        this.textDecoration,
        this.textDirection,
        this.decorationColor,
        this.haveShadow = false,
        this.fontFamily,
        this.foreground,
        this.wordSpacing,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: true,
      textDirection: textDirection,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          letterSpacing: letterSpacing,
          decoration: textDecoration,
          decorationColor: decorationColor,
          height: height,
          foreground: foreground,
          wordSpacing: wordSpacing),
    );
  }
}
