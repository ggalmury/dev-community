import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/widgets/atoms/article_type.dart';
import 'package:dev_community/widgets/atoms/buttons/primary_btn.dart';
import 'package:dev_community/widgets/molecules/sliver_tabbar.dart';
import 'package:dev_community/widgets/molecules/techskill_row.dart';
import 'package:dev_community/widgets/molecules/title_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PartyDetail extends StatefulWidget {
  final PartyArticle partyArticle;

  const PartyDetail({super.key, required this.partyArticle});

  @override
  State<PartyDetail> createState() => _PartyDetailState();
}

class _PartyDetailState extends State<PartyDetail> {
  Widget _articleInfoRow({required String title, required Widget child}) {
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
      appBar: AppBar(),
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
                                horizontal: 0, vertical: 25),
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
                                    ClipOval(
                                      child: Image.network(
                                        widget
                                            .partyArticle.poster.profileImgUrl,
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      widget.partyArticle.poster.nickname,
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
                                  title: "마감 기한",
                                  child: Text(
                                    Helper.isOverdue(
                                        widget.partyArticle.deadline),
                                    style: TextStyle(
                                      fontSize: CustomStyle.fs14,
                                    ),
                                  ),
                                ),
                                _articleInfoRow(
                                  title: "시작 예정",
                                  child: Text(
                                    Helper.formattedDate(
                                        widget.partyArticle.startDate),
                                    style: TextStyle(
                                      fontSize: CustomStyle.fs14,
                                    ),
                                  ),
                                ),
                                _articleInfoRow(
                                  title: "진행 방식",
                                  child: Text(
                                    widget.partyArticle.process == "온라인"
                                        ? widget.partyArticle.process
                                        : "${widget.partyArticle.process} / ${widget.partyArticle.location}",
                                    style: TextStyle(
                                      fontSize: CustomStyle.fs14,
                                    ),
                                  ),
                                ),
                                _articleInfoRow(
                                  title: "기간",
                                  child: Text(
                                    widget.partyArticle.span,
                                    style: TextStyle(
                                      fontSize: CustomStyle.fs14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.partyArticle.category == "프로젝트")
                            Column(
                              children: [
                                TitleColumn(
                                  title: "지원 현황",
                                  child: Column(
                                    children: widget
                                        .partyArticle.position!.entries
                                        .map((e) {
                                      return _articleInfoRow(
                                        title: e.key,
                                        child: Row(
                                          children: [
                                            Text(
                                              e.value.toString(),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            PrimaryBtn(
                                              label: "지원하기",
                                              onPressed: () {},
                                              widgetSize: WidgetSize.small,
                                              widgetColor: WidgetColor.purple,
                                              widgetShape: WidgetShape.square,
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
                                      techSkill:
                                          widget.partyArticle.techSkill!),
                                ),
                              ],
                            ),
                          TitleColumn(
                            title: "${widget.partyArticle.category} 소개",
                            child: Html(
                              data: widget.partyArticle.description,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // comment tab
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 30,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 30,
                              color: Colors.grey,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text("asdf"),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        color: Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
