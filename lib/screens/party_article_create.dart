import 'package:dev_community/main.dart';
import 'package:dev_community/utils/constant.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/utils/helpers/pair.dart';
import 'package:dev_community/widgets/atoms/buttons/btn_dropdown.dart';
import 'package:dev_community/widgets/atoms/buttons/btn_option.dart';
import 'package:dev_community/widgets/atoms/buttons/btn_submit.dart';
import 'package:dev_community/widgets/atoms/inputs/input_create.dart';
import 'package:dev_community/widgets/atoms/toggle_chip.dart';
import 'package:dev_community/widgets/molecules/article_create_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PartyArticleCreate extends StatefulWidget {
  const PartyArticleCreate({super.key});

  @override
  State<PartyArticleCreate> createState() => _PartyArticleCreateState();
}

class _PartyArticleCreateState extends State<PartyArticleCreate> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _techSkillController = TextEditingController();

  String currentType = "프로젝트";
  String? currentProcess;
  String? currentLocation;
  List<Pair<String?, int?>> currentPosition = [Pair(k: null, v: null)];
  List<String> currentTechSkill = [];

  List<String> searchedTechSkills = [];

  void _setType(String type) {
    setState(() {
      currentType = type;
    });
  }

  void _setProcess(String? process) {
    setState(() {
      currentProcess = process;
    });

    if (process == "온라인") {
      _setLocation(null);
    }
  }

  void _setLocation(String? location) {
    setState(() {
      currentLocation = location;
    });
  }

  void _setPosition(int index, dynamic position) {
    setState(() {
      currentPosition[index].k = position;
    });
  }

  void _setPositionCount(int index, String count) {
    setState(() {
      if (count == "") {
        currentPosition[index].v = null;
        return;
      }

      currentPosition[index].v = int.parse(count);
    });
  }

  void _addPositionRow() {
    setState(() {
      currentPosition.add(Pair(k: null, v: null));
    });
  }

  void _removePositionRow(index) {
    setState(() {
      currentPosition.removeAt(index);
    });
  }

  void _addTechSkill(String skill) {
    setState(() {
      currentTechSkill.add(skill);
    });

    _techSkillController.clear();
  }

  void _removeTechSkill(String skill) {
    setState(() {
      currentTechSkill.remove(skill);
    });
  }

  void _searchTechSkill() {
    RegExp regExp = RegExp(
        _techSkillController.text
            .replaceAll('\\', '\\\\')
            .replaceAll('+', '\\+'), // + 문자 이스케이프
        caseSensitive: false);

    setState(() {
      searchedTechSkills = Helper()
          .deduplicatedList<String>(techSkill, currentTechSkill)
          .where((element) =>
              _techSkillController.text.isNotEmpty && regExp.hasMatch(element))
          .take(4)
          .toList();
    });
  }

  void _submit() {
    loggerNoStack.i('''
    type: $currentType
    title: ${_titleController.text}
    process: $currentProcess
    location: $currentLocation
    position: $currentPosition
    techSkill: $currentTechSkill''');
  }

  List<String> _selectedPositions() {
    return currentPosition.where((p) => p.k != null).map((p) => p.k!).toList();
  }

  @override
  void initState() {
    super.initState();

    _techSkillController.addListener(_searchTechSkill);
  }

  @override
  void dispose() {
    _techSkillController.removeListener(_searchTechSkill);

    _titleController.dispose();
    _techSkillController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "파티 생성",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // TODO: implement submit button
          Padding(
            padding: const EdgeInsets.all(10),
            child: BtnSubmit(
              label: "완료",
              onPressed: _submit,
              widgetSize: WidgetSize.small,
              widgetColor: WidgetColor.mint,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                ArticleCreateColumn(
                  title: "유형",
                  child: Row(
                    children: List.generate(
                      type.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ToggleChip(
                            label: type[index],
                            onPressed: () {
                              _setType(type[index]);
                            },
                            toggle: currentType == type[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ArticleCreateColumn(
                  title: "$currentType명",
                  child: InputCreate(
                    textEditingController: _titleController,
                    hintText: "40자 이내로 적어주세요.",
                    maxLength: 40,
                  ),
                ),
                ArticleCreateColumn(
                  title: "진행방식",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BtnDropdown(
                        items: process,
                        onSelected: _setProcess,
                        hintText: "진행 방식",
                      ),
                      if (currentProcess != "온라인")
                        BtnDropdown(
                          items: location,
                          onSelected: _setLocation,
                          hintText: "지역",
                        ),
                    ],
                  ),
                ),
                ArticleCreateColumn(
                  title: "포지션",
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                          currentPosition.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      BtnDropdown(
                                        items: Helper()
                                            .deduplicatedList<String>(
                                                position, _selectedPositions()),
                                        hintText: "포지션",
                                        onSelected: (position) {
                                          _setPosition(index, position);
                                        },
                                      ),
                                      const SizedBox(
                                        width: 17,
                                      ),
                                      InputCreate(
                                        width: 80,
                                        keyboardType: TextInputType.number,
                                        onChanged: (count) {
                                          _setPositionCount(index, count);
                                        },
                                      ),
                                    ],
                                  ),
                                  if (index != 0)
                                    OutlinedButton(
                                      onPressed: () {
                                        _removePositionRow(index);
                                      },
                                      child: const Text("삭제"),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if (_selectedPositions().length == currentPosition.length)
                        Align(
                          alignment: Alignment.centerRight,
                          child: BtnOption(
                            label: "추가",
                            onPressed: _addPositionRow,
                          ),
                        )
                    ],
                  ),
                ),
                // TODO: Implement here
                ArticleCreateColumn(
                  title: "기술 스택",
                  child: Column(
                    children: [
                      Column(
                        children: [
                          InputCreate(
                            textEditingController: _techSkillController,
                            hintText: "기술 스택을 입력해 주세요.",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 5,
                          children:
                              List.generate(searchedTechSkills.length, (index) {
                            return ToggleChip(
                              label: searchedTechSkills[index],
                              onPressed: () {
                                _addTechSkill(searchedTechSkills[index]);
                              },
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 5,
                          children:
                              List.generate(currentTechSkill.length, (index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/skills/${currentTechSkill[index]}.svg",
                                  width: 32,
                                  height: 32,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _removeTechSkill(currentTechSkill[index]);
                                  },
                                  child: const Icon(Icons.close),
                                )
                              ],
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
