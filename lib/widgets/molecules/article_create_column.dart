import 'package:flutter/material.dart';

class ArticleCreateColumn extends StatelessWidget {
  final String title;
  final Widget child;

  const ArticleCreateColumn(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          child,
        ],
      ),
    );
  }
}
