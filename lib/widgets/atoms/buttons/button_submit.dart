import 'package:flutter/material.dart';

class ButtonSubmit extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const ButtonSubmit(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.height,
      this.backgroundColor,
      this.foregroundColor,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
