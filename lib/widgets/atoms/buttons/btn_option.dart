import 'package:flutter/material.dart';

class BtnOption extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const BtnOption({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
