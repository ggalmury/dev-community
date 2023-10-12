import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/widgets/molecules/article_profile.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: CustomColor.grey,
          ),
        ),
      ),
      constraints: const BoxConstraints(
        minHeight: 120,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleProfile(
                nickname: "다리우스",
                imageSrc:
                    "http://k.kakaocdn.net/dn/hNCUd/btskg9bLRFi/gK4aKViyxA20R6IQJ8W5nk/img_640x640.jpg",
                craetedAt: DateTime.now(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("comment"),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("댓글 열기"),
                  Row(
                    children: [
                      Helper.svgFactory("assets/svgs/commons/text.svg", 20),
                      const SizedBox(
                        width: 7,
                      ),
                      const Text("2"),
                    ],
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
