import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/screens/party_article_detail.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
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
        builder: (BuildContext context) => PartyArticleDetail(
          partyArticle: widget.partyArticle,
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
        margin: const EdgeInsets.only(top: 10),
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
                      ArticleType(label: widget.partyArticle.category),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        Helper.isOverdue(widget.partyArticle.deadline),
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
                widget.partyArticle.title,
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
              Text(widget.partyArticle.location == null
                  ? widget.partyArticle.process
                  : "${widget.partyArticle.process} | ${widget.partyArticle.location}"),
              const Spacer(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: TechSkillRow(techSkill: widget.partyArticle.techSkill),
              ),
              const SizedBox(
                height: 12,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.partyArticle.position.entries.map((e) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      margin: const EdgeInsets.only(right: 10, top: 10),
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
