import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class ArticleType extends StatelessWidget {
  final String label;

  const ArticleType({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      decoration: BoxDecoration(
        color: label == "프로젝트" ? CustomColor.blueLight : CustomColor.redLight,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: label == "프로젝트" ? CustomColor.blue : CustomColor.red,
          ),
        ),
      ),
    );
  }
}
