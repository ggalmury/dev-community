import 'package:dev_community/utils/constant.dart';
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
  String currentType = type[0];
  String? currentProcess;

  void _articleTypeToggle(String label) {
    setState(() {
      currentType = label;
    });
  }

  void _setProcess(dynamic process) {
    setState(() {
      currentProcess = process;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
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
                              _articleTypeToggle(type[index]);
                            },
                            toggle: currentType == type[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ArticleCreateColumn(
                  title: currentType == type[0] ? "프로젝트명" : "스터디명",
                  child: InputCreate(
                    textEditingController: _titleController,
                    hintText: "40자 이내로 적어주세요.",
                    maxLength: 40,
                  ),
                ),
                ArticleCreateColumn(
                  title: "진행방식",
                  child: ButtonDropdown(
                    items: process,
                    onChanged: _setProcess,
                    value: currentProcess,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
