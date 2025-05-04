import 'package:flutter/material.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/widgets/text/customText.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final int? maxline;
  final Color fillColor;
  final FocusNode? focusNode;
  final TextStyle? style;
  final Opacity? opacity;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.hintStyle,
    this.decoration,
    this.onChanged,
    this.validator,
    this.contentPadding,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor = ClrUtils.primary,
    this.borderColor = ClrUtils.border,
    this.maxline,
    this.focusNode,
    this.style,
    this.opacity,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _isObscured : widget.obscureText,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      maxLines: widget.maxline,
      style: widget.style ??
          TextStylesCons.custom(
              fontSize: 14,
              color: ClrUtils.textPrimary,
              fontWeight: FontWeight.w500),
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: widget.decoration ??
          InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                TextStyle(
                    color: ClrUtils.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            filled: true,
            fillColor: widget.fillColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ClrUtils.textTertiary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: ClrUtils.icon,
                      size: 18,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : widget.suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: widget.suffixIcon,
                      )
                    : null,
          ),
    );
  }
}
