import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/screens/party_detail.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:dev_community/widgets/atoms/article_type.dart';
import 'package:dev_community/widgets/molecules/techskill_row.dart';
import 'package:flutter/material.dart';
import '../../utils/helpers/helper.dart';

class PartyArticleContainer extends StatefulWidget {
  final PartyArticle partyArticle;

  const PartyArticleContainer({super.key, required this.partyArticle});

  @override
  State<PartyArticleContainer> createState() => _PartyArticleContainerState();
}

class _PartyArticleContainerState extends State<PartyArticleContainer> {
  void _navigateToDetail() {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => PartyDetail(
          partyArticle: widget.partyArticle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToDetail,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColor.grey,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ArticleType(label: widget.partyArticle.category),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 60,
                          height: 25,
                          decoration: BoxDecoration(
                            color:
                                Helper.isOverdue(widget.partyArticle.deadline)
                                    ? CustomColor.grey
                                    : CustomColor.black,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              Helper.isOverdue(widget.partyArticle.deadline)
                                  ? "마감"
                                  : "모집중",
                              style: TextStyle(
                                fontSize: CustomStyle.fs12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.favorite_border)
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  widget.partyArticle.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: CustomStyle.fs18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.partyArticle.location == null
                      ? widget.partyArticle.process
                      : "${widget.partyArticle.process} | ${widget.partyArticle.location}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColor.greyHeavy,
                    fontSize: CustomStyle.fs14,
                  ),
                ),
                if (widget.partyArticle.category == "프로젝트")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: TechSkillRow(
                            techSkill: widget.partyArticle.techSkill!),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children:
                                widget.partyArticle.position!.entries.map((e) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: CustomColor.greyLight,
                                ),
                                child: Center(
                                  child: Text(
                                    e.key,
                                    style: TextStyle(
                                      fontSize: CustomStyle.fs14,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
