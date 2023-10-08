import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final double? width;
  final double? fontSize;

  const TextBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
