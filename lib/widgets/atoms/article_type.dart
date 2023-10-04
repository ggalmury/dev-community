import 'package:flutter/material.dart';

class ArticleType extends StatelessWidget {
  final String label;

  const ArticleType({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      color: label == "프로젝트"
          ? const Color.fromARGB(255, 213, 236, 255)
          : const Color.fromARGB(255, 255, 218, 255),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
