import 'package:dev_community/models/party_article_model.dart';
import 'package:dev_community/screens/party_article_detail.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/widgets/molecules/techskill_row.dart';
import 'package:flutter/material.dart';

import '../../utils/helpers/helper.dart';

class PartyArticle extends StatefulWidget {
  final PartyArticleModel partyArticleModel;

  const PartyArticle({super.key, required this.partyArticleModel});

  @override
  State<PartyArticle> createState() => _PartyArticleState();
}

class _PartyArticleState extends State<PartyArticle> {
  void _navigateToDetail() {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => PartyArticleDetail(
          partyArticleModel: widget.partyArticleModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToDetail,
      child: Container(
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
                        width: 120,
                        height: 30,
                        color: CustomColor.whiteGrey2,
                        child: Center(
                          child: Text(
                            widget.partyArticleModel.type,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "마감 D-${Helper().dayDifference(DateTime.now(), widget.partyArticleModel.deadline)}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
              const SizedBox(
                height: 20,
              ),
              Text(
                  "${widget.partyArticleModel.process} | ${widget.partyArticleModel.location}"),
              const Spacer(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    TechSkillRow(techSkill: widget.partyArticleModel.techSkill),
              ),
              const SizedBox(
                height: 12,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.partyArticleModel.position.entries.map((e) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
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
                          e.key,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
