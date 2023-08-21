import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class ChosenTag extends StatelessWidget {
  final String label;

  const ChosenTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: const BoxDecoration(
        color: CustomColor.whiteGrey1,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(label),
    );
  }
}
