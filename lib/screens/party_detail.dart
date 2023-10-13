import 'package:dev_community/apis/party_api.dart';
import 'package:dev_community/models/common/comment.dart';
import 'package:dev_community/models/common/comment_group.dart';
import 'package:dev_community/models/party/party_article.dart';
import 'package:dev_community/models/party/party_comment_create.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/utils/helpers/screen_helper.dart';
import 'package:dev_community/widgets/atoms/article_type.dart';
import 'package:dev_community/widgets/atoms/buttons/primary_btn.dart';
import 'package:dev_community/widgets/atoms/inputs/nonborder_input.dart';
import 'package:dev_community/widgets/molecules/article_profile.dart';
import 'package:dev_community/widgets/molecules/sliver_tabbar.dart';
import 'package:dev_community/widgets/molecules/techskill_row.dart';
import 'package:dev_community/widgets/molecules/title_column.dart';
import 'package:dev_community/widgets/organisms/comment_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class PartyDetail extends StatefulWidget {
  final PartyArticle partyArticle;

  const PartyDetail({super.key, required this.partyArticle});

  @override
  State<PartyDetail> createState() => _PartyDetailState();
}

class _PartyDetailState extends State<PartyDetail> {
  final TextEditingController _commentController = TextEditingController();
  final EdgeInsets contentPadding =
      const EdgeInsets.only(right: 25, left: 25, top: 60);

  List<CommentGroup> comments = [];

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

  Future<void> _submitComment() async {
    PartyCommentCreate partyCommentCreate = PartyCommentCreate(
        postId: widget.partyArticle.id,
        comment: _commentController.text,
        depth: 0);

    Comment comment =
        await context.read<PartyApi>().createComment(partyCommentCreate);

    CommentGroup newComment = CommentGroup(comment: comment, subComment: []);

    setState(() {
      comments.add(newComment);
    });

    _commentController.clear();

    if (!mounted) return;

    ScreenHelper.alertDialogHandler(context, title: "댓글이 등록되었습니다!");
  }

  Future<void> _fetchCommentList() async {
    List<CommentGroup> commentGroup =
        await context.read<PartyApi>().getComment(widget.partyArticle.id);

    setState(() {
      comments = commentGroup;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _fetchCommentList();
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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
                  child: SizedBox(
                    height: 220,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ArticleProfile(
                                nickname: widget.partyArticle.poster.nickname,
                                imageSrc:
                                    widget.partyArticle.poster.profileImgUrl,
                                craetedAt: widget.partyArticle.createdAt,
                              ),
                              const Text("조회수 20"),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                widget.partyArticle.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: CustomStyle.fs20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ArticleType(label: widget.partyArticle.category),
                            ],
                          ),
                        ],
                      ),
                    ),
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
            body: TabBarView(
              children: [
                // info tab
                SingleChildScrollView(
                  child: Padding(
                    padding: contentPadding,
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
                                  Helper.isOverdue(widget.partyArticle.deadline)
                                      ? "마감"
                                      : "마감 D-${Helper.dayDifference(DateTime.now(), widget.partyArticle.deadline)}",
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
                                    techSkill: widget.partyArticle.techSkill!),
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
                      child: Padding(
                        padding: contentPadding,
                        child: ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return CommentContainer(
                                commentGroup: comments[index]);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NonBorderInput(
                              textEditingController: _commentController,
                              width: 270,
                              hintText: "댓글을 입력해주세요.",
                            ),
                            PrimaryBtn(
                              label: "등록",
                              onPressed: _submitComment,
                              widgetSize: WidgetSize.small,
                              widgetColor: WidgetColor.purple,
                              widgetShape: WidgetShape.square,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
