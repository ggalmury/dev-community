import 'package:flutter/material.dart';

class BtnCategory extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const BtnCategory({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
