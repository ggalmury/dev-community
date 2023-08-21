import 'package:dev_community/models/party_article_model.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/helpers/helper.dart';

class PartyArticle extends StatefulWidget {
  final PartyArticleModel partyArticleModel;

  const PartyArticle({super.key, required this.partyArticleModel});

  @override
  State<PartyArticle> createState() => _PartyArticleState();
}

class _PartyArticleState extends State<PartyArticle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: const EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 30,
                        color: CustomColor.whiteGrey2,
                        child: Center(
                          child: Text(widget.partyArticleModel.type),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "마감 D-${Helper().dayDifference(DateTime.now(), widget.partyArticleModel.deadline)}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  const Icon(Icons.favorite_border)
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                widget.partyArticleModel.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    widget.partyArticleModel.techSkill.length,
                    (index) {
                      // techskill chip
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: SvgPicture.asset(
                          "assets/svgs/skills/${widget.partyArticleModel.techSkill[index]}.svg",
                          width: 25,
                          height: 25,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    widget.partyArticleModel.position.length,
                    (index) {
                      // techskill chip
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: CustomColor.whiteGrey2,
                        ),
                        child: Center(
                          child: Text(
                            widget.partyArticleModel.position[index],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
