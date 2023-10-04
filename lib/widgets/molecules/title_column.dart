import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';

class TitleColumn extends StatelessWidget {
  final String title;
  final Widget child;

  const TitleColumn({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: CustomStyle.fs20,
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
