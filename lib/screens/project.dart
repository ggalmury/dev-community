import 'package:dev_community/bloc/screen/project/project_search_option_bloc.dart';
import 'package:dev_community/main.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/helpers/screen_helper.dart';
import 'package:dev_community/widgets/atoms/inputs/input_search.dart';
import 'package:dev_community/widgets/components/search_option_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/components/project_container.dart';
import 'package:dev_community/utils/constant.dart' as constants;

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

  void _onOptionSelect(List<String> list, String title) {
    ScreenHelper()
        .modalBottomSheetHandler(context, _bottomSheetBody(list, title), 450);
  }

  Widget _bottomSheetBody(List<String> list, String title) {
    return Column(
      children: [
        SizedBox(
            height: 30,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
        const Divider(
          height: 10,
          thickness: 0.5,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(list.length, (index) {
                  return Container(
                    color: CustomColor.whiteGrey,
                    padding: const EdgeInsets.all(10),
                    child: Text(list[index]),
                  );
                })),
          ),
        ),
        const SizedBox(height: 100, child: Text("버튼 자리")),
      ],
    );
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
        backgroundColor: CustomColor.whiteGrey,
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
                          color: CustomColor.whiteGrey,
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
                                  Column(children: [
                                    SearchOptionRow(
                                      title: "기술스택",
                                      onPressed: () {
                                        _onOptionSelect(
                                            constants.techSkill, "기술스택");
                                      },
                                      optionList: context
                                          .read<ProjectSearchOptionBloc>()
                                          .state
                                          .techSkill,
                                    ),
                                    SearchOptionRow(
                                      title: "포지션",
                                      onPressed: () {
                                        _onOptionSelect(
                                            constants.position, "포지션");
                                      },
                                      optionList: context
                                          .read<ProjectSearchOptionBloc>()
                                          .state
                                          .position,
                                    ),
                                    SearchOptionRow(
                                      title: "진행방식",
                                      onPressed: () {
                                        _onOptionSelect(
                                            constants.process, "진행방식");
                                      },
                                      optionList: context
                                          .read<ProjectSearchOptionBloc>()
                                          .state
                                          .process,
                                    ),
                                    SearchOptionRow(
                                      title: "모집기한",
                                      onPressed: () {
                                        _onOptionSelect(
                                            constants.techSkill, "모집기한");
                                      },
                                      optionList: context
                                          .read<ProjectSearchOptionBloc>()
                                          .state
                                          .deadline,
                                    ),
                                  ]),
                              ]),
                        ),
                      ],
                    ),
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
          ),
        ));
  }
}
