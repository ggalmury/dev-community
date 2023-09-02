import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;

  const IconBtn({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon),
    );
  }
}
