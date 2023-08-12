import 'package:dev_community/utils/helpers/screen_helper.dart';
import 'package:dev_community/widgets/atoms/inputs/input_search.dart';
import 'package:dev_community/widgets/components/search_option_row.dart';
import 'package:flutter/material.dart';
import '../widgets/components/project_container.dart';

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  final TextEditingController _searchOptionController = TextEditingController();
  bool searchOptionToggle = false;

  void _setSearchOptionToggle() {
    setState(() {
      searchOptionToggle = !searchOptionToggle;
    });
  }

  void _onTechSkillSelect() {
    ScreenHelper().modaBottomSheetHandler(context);
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
            SizedBox(width: 50, child: Icon(Icons.javascript)),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputSearch(
                                textEditingController: _searchOptionController,
                                hintText: "검색할 제목을 입력해 주세요."),
                            IntrinsicWidth(
                              child: TextButton(
                                  onPressed: _setSearchOptionToggle,
                                  child: Row(
                                    children: [
                                      const Text("상세검색"),
                                      Icon(searchOptionToggle
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down)
                                    ],
                                  )),
                            ),
                            if (searchOptionToggle)
                              Container(
                                color: Colors.green,
                                child: Column(children: [
                                  SearchOptionRow(
                                    title: "기술 스택",
                                    onPressed: _onTechSkillSelect,
                                    optionList: const [
                                      "asdf",
                                      "asdf",
                                      "asdf",
                                      "asdf",
                                      "asdf",
                                      "asdf"
                                    ],
                                  )
                                ]),
                              )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const ProjectContainer();
              },
              childCount: 20,
            ))
          ],
        ));
  }
}
