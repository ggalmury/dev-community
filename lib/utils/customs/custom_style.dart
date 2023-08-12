import 'package:flutter/material.dart';

class CustomStyle {
  static ButtonStyle defaultButtonStyle = ButtonStyle(
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    foregroundColor: MaterialStateProperty.all(Colors.black),
  );
}
