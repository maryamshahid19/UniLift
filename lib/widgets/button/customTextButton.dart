import 'package:flutter/material.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/widgets/text/customText.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onpressed,
    this.color = ClrUtils.textTertiary,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStylesCons.custom(
            fontSize: fontSize, color: color, fontWeight: fontWeight),
      ),
    );
  }
}
