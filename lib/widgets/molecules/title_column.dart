import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';

class TitleColumn extends StatelessWidget {
  final String title;
  final Widget child;
  final bool? required;
  final String? requiredLabel;

  const TitleColumn(
      {super.key,
      required this.title,
      required this.child,
      this.required,
      this.requiredLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: CustomStyle.fs18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: title),
                if (required == true)
                  const TextSpan(
                    text: "* ",
                    style: TextStyle(color: Colors.red),
                  ),
                if (required == true && requiredLabel != null)
                  TextSpan(
                    text: requiredLabel,
                    style: TextStyle(
                      fontSize: CustomStyle.fs14,
                      color: CustomColor.grey,
                    ),
                  )
              ],
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
