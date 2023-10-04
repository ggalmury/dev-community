import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/widgets/atoms/article_type.dart';
import 'package:dev_community/widgets/molecules/sliver_tabbar.dart';
import 'package:dev_community/widgets/molecules/techskill_row.dart';
import 'package:dev_community/widgets/molecules/title_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PartyArticleDetail extends StatefulWidget {
  final PartyArticle partyArticle;

  const PartyArticleDetail({super.key, required this.partyArticle});

  @override
  State<PartyArticleDetail> createState() => _PartyArticleDetailState();
}

class _PartyArticleDetailState extends State<PartyArticleDetail> {
  Widget _articleInfoRow(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: CustomStyle.fs16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            data,
            style: TextStyle(
              fontSize: CustomStyle.fs14,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 150,
                          color: CustomColor.black,
                        ),
                        Container(
                          height: 70,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: CustomColor.whiteGrey2.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.partyArticle.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: CustomStyle.fs20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/darius.png"),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  widget.partyArticle.poster,
                                  style: TextStyle(
                                    fontSize: CustomStyle.fs16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            ArticleType(label: widget.partyArticle.category),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverTabBar(),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            TitleColumn(
                              title: "${widget.partyArticle.category} 정보",
                              child: Column(
                                children: [
                                  _articleInfoRow(
                                      "마감 기한",
                                      Helper.isOverdue(
                                          widget.partyArticle.deadline)),
                                  _articleInfoRow(
                                      "진행 방식",
                                      widget.partyArticle.process == "온라인"
                                          ? widget.partyArticle.process
                                          : "${widget.partyArticle.process} / ${widget.partyArticle.location}"),
                                  _articleInfoRow(
                                      "기간", widget.partyArticle.span),
                                ],
                              ),
                            ),
                            TitleColumn(
                              title: "지원 현황",
                              child: Column(
                                children: widget.partyArticle.position.entries
                                    .map((e) {
                                  return SizedBox(
                                    height: 55,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.key,
                                          style: TextStyle(
                                            fontSize: CustomStyle.fs16,
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
                    ),
                    const SizedBox(
                      child: Text("댓글"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
