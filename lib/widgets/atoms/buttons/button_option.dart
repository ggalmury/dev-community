import 'package:flutter/material.dart';

class ButtonOption extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const ButtonOption({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, child: Text(title));
  }
}
