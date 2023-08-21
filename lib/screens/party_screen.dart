import 'package:dev_community/bloc/screen/project/party_article_bloc.dart';
import 'package:dev_community/main.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/widgets/atoms/inputs/input_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/enum.dart';
import '../widgets/components/party_article.dart';
import 'package:dev_community/utils/constant.dart' as constants;
import '../widgets/components/search_filter_row.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({super.key});

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  final TextEditingController _searchOptionController = TextEditingController();
  bool searchFilterToggle = false;

  void _setSearchFilterToggle() {
    setState(() {
      searchFilterToggle = !searchFilterToggle;
    });
  }

  @override
  void dispose() {
    _searchOptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("프로젝트"),
          centerTitle: false,
          actions: const [
            SizedBox(width: 50, child: Icon(Icons.menu)),
          ],
        ),
        backgroundColor: CustomColor.whiteGrey1,
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));

            loggerNoStack.i("refresh project page");
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          color: CustomColor.whiteGrey1,
                          child: const Center(
                            child: Text("banner"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputSearch(
                                    textEditingController:
                                        _searchOptionController,
                                    hintText: "검색할 제목을 입력해 주세요."),
                                IntrinsicWidth(
                                  child: TextButton(
                                      onPressed: _setSearchFilterToggle,
                                      child: Row(
                                        children: [
                                          const Text("상세검색"),
                                          Icon(
                                            searchFilterToggle
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                          )
                                        ],
                                      )),
                                ),
                                if (searchFilterToggle)
                                  const Column(children: [
                                    SearchFilterRow(
                                      label: "기술스택",
                                      category: SearchFilterCategory.techSkill,
                                      elements: constants.techSkill,
                                    ),
                                    SearchFilterRow(
                                      label: "포지션",
                                      category: SearchFilterCategory.position,
                                      elements: constants.position,
                                    ),
                                    SearchFilterRow(
                                      label: "진행방식",
                                      category: SearchFilterCategory.process,
                                      elements: constants.process,
                                    ),
                                    SearchFilterRow(
                                      label: "지역",
                                      category: SearchFilterCategory.location,
                                      elements: constants.location,
                                    ),
                                    SearchFilterRow(
                                      label: "타입",
                                      category: SearchFilterCategory.type,
                                      elements: constants.type,
                                    ),
                                  ]),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<PartyArticleBloc, DefaultPartyArticleState>(
                builder: (context, state) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return PartyArticle(
                          partyArticleModel: state.partyArticleModel[index],
                        );
                      },
                      childCount: state.partyArticleModel.length,
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
