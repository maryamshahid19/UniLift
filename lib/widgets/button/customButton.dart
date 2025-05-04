import 'package:flutter/material.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/widgets/text/customText.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double fontSize;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final double borderWidth;
  final String? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = ClrUtils.tertiary,
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.elevation = 0,
    this.fontSize = 14.0,
    this.height = 48,
    this.width = double.infinity,
    this.fontWeight,
    this.borderColor,
    this.borderWidth = 1,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        minimumSize: Size(width, height),
        padding: EdgeInsets.zero,
        foregroundColor: textColor,
        backgroundColor: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: borderWidth, color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Image.asset(icon!, height: 24, width: 24),
            SizedBox(width: 5),
          ],
          Text(
            text,
            style: TextStylesCons.custom(
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight ?? FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
