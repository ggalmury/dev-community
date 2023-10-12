import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class ArticleProfile extends StatelessWidget {
  final String nickname;
  final String imageSrc;
  final DateTime craetedAt;

  const ArticleProfile(
      {super.key,
      required this.nickname,
      required this.imageSrc,
      required this.craetedAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            imageSrc,
            width: 35,
            height: 35,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 13,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nickname,
              style: TextStyle(
                fontSize: CustomStyle.fs16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              Helper.timePassage(craetedAt),
              style: TextStyle(
                fontSize: CustomStyle.fs14,
              ),
            ),
          ],
        )
      ],
    );
  }
}
