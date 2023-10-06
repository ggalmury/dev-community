import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/widgets/atoms/article_type.dart';
import 'package:dev_community/widgets/atoms/buttons/secondary_btn.dart';
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
  Widget _articleInfoRow(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
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
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      const SizedBox(
                        height: 220,
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 180,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: CustomColor.whiteGrey2,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Padding(
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
                                          // TODO: change image to poster's image
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
                                ArticleType(
                                    label: widget.partyArticle.category),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverPersistentHeader(
                      pinned: true, delegate: SliverTabBar(tabs: ["정보", "댓글"])),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: TabBarView(
                children: [
                  // info tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleColumn(
                            title: "${widget.partyArticle.category} 정보",
                            child: Column(
                              children: [
                                _articleInfoRow(
                                  "마감 기한",
                                  Text(
                                    Helper.isOverdue(
                                        widget.partyArticle.deadline),
                                    style: TextStyle(
                                      fontSize: CustomStyle.fs14,
                                    ),
                                  ),
                                ),
                                _articleInfoRow(
                                  "진행 방식",
                                  Text(
                                    widget.partyArticle.process == "온라인"
                                        ? widget.partyArticle.process
                                        : "${widget.partyArticle.process} / ${widget.partyArticle.location}",
                                    style: TextStyle(
                                      fontSize: CustomStyle.fs14,
                                    ),
                                  ),
                                ),
                                _articleInfoRow(
                                  "기간",
                                  Text(
                                    widget.partyArticle.span,
                                    style: TextStyle(
                                      fontSize: CustomStyle.fs14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TitleColumn(
                            title: "지원 현황",
                            child: Column(
                              children:
                                  widget.partyArticle.position.entries.map((e) {
                                return _articleInfoRow(
                                  e.key,
                                  Row(
                                    children: [
                                      Text(
                                        e.value.toString(),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SecondaryBtn(
                                        label: "지원하기",
                                        onPressed: () {},
                                        widgetSize: WidgetSize.small,
                                      ),
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
                  // comment tab
                  const SizedBox(
                    child: Center(
                      child: Text("댓글"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
