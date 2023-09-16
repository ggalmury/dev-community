import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/widgets/molecules/techskill_row.dart';
import 'package:dev_community/widgets/molecules/title_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';

class PartyArticleDetail extends StatefulWidget {
  final PartyArticle partyArticle;

  const PartyArticleDetail({super.key, required this.partyArticle});

  @override
  State<PartyArticleDetail> createState() => _PartyArticleDetailState();
}

class _PartyArticleDetailState extends State<PartyArticleDetail> {
  Widget _articleOptionColumn(String svgPath, String label) {
    return Column(
      children: [
        SvgPicture.asset(
          svgPath,
          width: 30,
          height: 30,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.partyArticle.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/darius.png"),
                              )),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.partyArticle.poster,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Divider(
                          height: 30,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _articleOptionColumn(
                                "assets/svgs/commons/category.svg",
                                widget.partyArticle.category),
                            _articleOptionColumn(
                                "assets/svgs/commons/process.svg",
                                widget.partyArticle.process),
                            _articleOptionColumn(
                              "assets/svgs/commons/play.svg",
                              DateFormat("yy.MM.dd")
                                  .format(widget.partyArticle.startDate),
                            ),
                            _articleOptionColumn(
                                "assets/svgs/commons/calendar.svg",
                                widget.partyArticle.span),
                            _articleOptionColumn(
                                "assets/svgs/commons/alarm.svg",
                                Helper.isOverdue(widget.partyArticle.deadline)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    TitleColumn(
                      title: "지원 현황",
                      child: Column(
                        children: widget.partyArticle.position.entries.map((e) {
                          return SizedBox(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.key,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.value.toString(),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: const Text("지원하기"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // tech skill container
                    TitleColumn(
                      title: "기술 스택",
                      child: TechSkillRow(
                          techSkill: widget.partyArticle.techSkill),
                    ),
                    TitleColumn(
                      title: "프로젝트 소개",
                      child: Html(
                        data: widget.partyArticle.description,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
