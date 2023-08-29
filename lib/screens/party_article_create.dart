import 'package:dev_community/main.dart';
import 'package:dev_community/utils/constant.dart';
import 'package:dev_community/utils/helpers/pair.dart';
import 'package:dev_community/widgets/atoms/buttons/button_dropdown.dart';
import 'package:dev_community/widgets/atoms/inputs/input_create.dart';
import 'package:dev_community/widgets/atoms/toggle_chip.dart';
import 'package:dev_community/widgets/molecules/article_create_column.dart';
import 'package:flutter/material.dart';

class PartyArticleCreate extends StatefulWidget {
  const PartyArticleCreate({super.key});

  @override
  State<PartyArticleCreate> createState() => _PartyArticleCreateState();
}

class _PartyArticleCreateState extends State<PartyArticleCreate> {
  final TextEditingController _titleController = TextEditingController();
  final List<TextEditingController> _positionCountControllers = [
    TextEditingController()
  ];

  String currentType = "프로젝트";
  String? currentProcess;
  String? currentLocation;
  List<Pair<String?, int>> currentPosition = [Pair(k: null, v: 0)];

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

  void _addPositionRow() {
    setState(() {
      currentPosition = [...currentPosition, Pair(k: null, v: 0)];
    });

    _positionCountControllers.add(TextEditingController());
  }

  void _removePositionRow(index) {
    setState(() {
      currentPosition.removeAt(index);
    });

    _positionCountControllers.removeLast().dispose();
  }

  List<String> _selectedPositions() {
    return currentPosition.where((p) => p.k != null).map((p) => p.k!).toList();
  }

  List<String> _filteredPositions() {
    Set<String> nextPositionSet = Set.from(position);
    Set<String> curPosiitonSet = Set.from(_selectedPositions());
    nextPositionSet = nextPositionSet.difference(curPosiitonSet);

    return List.from(nextPositionSet);
  }

  @override
  void dispose() {
    _titleController.dispose();

    for (TextEditingController c in _positionCountControllers) {
      c.dispose();
    }

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
                      ButtonDropdown(
                        items: process,
                        onSelected: _setProcess,
                        value: currentProcess,
                        hint: "진행 방식",
                      ),
                      if (currentProcess != "온라인")
                        ButtonDropdown(
                          items: location,
                          onSelected: _setLocation,
                          value: currentLocation,
                          hint: "지역",
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
                                      ButtonDropdown(
                                        items: _filteredPositions(),
                                        onSelected: (pos) {
                                          _setPosition(index, pos);
                                        },
                                        hint: "포지션",
                                      ),
                                      const SizedBox(
                                        width: 17,
                                      ),
                                      InputCreate(
                                        textEditingController:
                                            _positionCountControllers[index],
                                        hintText: "",
                                        width: 70,
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
                          child: OutlinedButton(
                            onPressed: _addPositionRow,
                            child: const Text("추가"),
                          ),
                        )
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    loggerNoStack.i('''
                                    type: $currentType
                                    title: ${_titleController.text}
                                    process: $currentProcess
                                    location: $currentLocation
                                    position: $currentPosition''');
                  },
                  child: const Text("상태 확인"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
