import 'package:flutter/material.dart';

class ButtonCategory extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const ButtonCategory(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
