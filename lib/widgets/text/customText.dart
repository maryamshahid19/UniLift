import 'package:flutter/material.dart';
import 'package:unilift/constants/color_constants.dart';

class TextStylesCons {
  // Customizable text style method
  static TextStyle custom({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    double letterSpacing = 0.0,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationColor: color,
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final int? maxline;
  final TextOverflow? overflow;
  final double letterSpacing;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = ClrUtils.textPrimary,
    this.decoration,
    this.textAlign,
    this.maxline,
    this.overflow,
    this.letterSpacing = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: overflow,
      text,
      maxLines: maxline,
      style: TextStylesCons.custom(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
    );
  }
}
