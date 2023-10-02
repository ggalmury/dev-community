import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/widgets.dart';

class ArticleType extends StatelessWidget {
  final String label;

  const ArticleType({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      color: CustomColor.whiteGrey2,
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
