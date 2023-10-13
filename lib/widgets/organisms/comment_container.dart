import 'package:dev_community/models/common/comment_group.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/widgets/molecules/article_profile.dart';
import 'package:flutter/material.dart';

class CommentContainer extends StatelessWidget {
  final CommentGroup commentGroup;

  const CommentContainer({super.key, required this.commentGroup});

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
                nickname: commentGroup.comment.poster.nickname,
                imageSrc: commentGroup.comment.poster.profileImgUrl,
                craetedAt: commentGroup.comment.createdAt,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(commentGroup.comment.comment),
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
                      Text(commentGroup.subComment.length.toString()),
                    ],
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
