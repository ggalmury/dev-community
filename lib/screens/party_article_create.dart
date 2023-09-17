import 'package:dev_community/apis/party_api.dart';
import 'package:dev_community/bloc/global/user_account_bloc.dart';
import 'package:dev_community/models/party_article_creator.dart';
import 'package:dev_community/screens/party.dart';
import 'package:dev_community/utils/constant.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/utils/helpers/pair.dart';
import 'package:dev_community/utils/helpers/screen_helper.dart';
import 'package:dev_community/widgets/atoms/buttons/dropdown_btn.dart';
import 'package:dev_community/widgets/atoms/buttons/primary_btn.dart';
import 'package:dev_community/widgets/atoms/buttons/secondary_btn.dart';
import 'package:dev_community/widgets/atoms/inputs/create_input.dart';
import 'package:dev_community/widgets/atoms/toggle_chip.dart';
import 'package:dev_community/widgets/molecules/title_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

class PartyArticleCreate extends StatefulWidget {
  const PartyArticleCreate({super.key});

  @override
  State<PartyArticleCreate> createState() => _PartyArticleCreateState();
}

class _PartyArticleCreateState extends State<PartyArticleCreate> {
  final HtmlEditorController _htmlEditorController = HtmlEditorController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _techSkillController = TextEditingController();

  String currentCategory = "프로젝트";
  String? currentLocation;
  DateTime? currentStartDate;
  String? currentSpan;
  DateTime? currentDeadline;
  String? currentProcess;
  List<Pair<String?, int?>> currentPosition = [Pair(k: null, v: null)];
  List<String> currentTechSkill = [];

  List<String> searchedTechSkills = [];

  void _setCategory(String category) {
    setState(() {
      currentCategory = category;
    });
  }

  void _setStartDate() async {
    DateTime? startDate = await ScreenHelper.datePickerHandler(context);

    if (startDate != null) {
      setState(() {
        currentStartDate = startDate;
      });
    }
  }

  void _setSpan(String? span) {
    setState(() {
      currentSpan = span;
    });
  }

  void _setDeadline() async {
    DateTime? deadline = await ScreenHelper.datePickerHandler(context);

    if (deadline != null) {
      setState(() {
        currentDeadline = deadline;
      });
    }
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
      try {
        currentPosition[index].v = int.parse(count);
      } catch (e) {
        currentPosition[index].v = null;
      }
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
            .replaceAll('+', '\\+'),
        caseSensitive: false);

    setState(() {
      searchedTechSkills = Helper.deduplicatedList<String>(
              techSkill, currentTechSkill)
          .where((element) =>
              _techSkillController.text.isNotEmpty && regExp.hasMatch(element))
          .take(4)
          .toList();
    });
  }

  List<String> _selectedPositions() {
    return currentPosition.where((p) => p.k != null).map((p) => p.k!).toList();
  }

  bool _validate() {
    if (_titleController.text == "") {
      ScreenHelper.alertDialogHandler(context, "$currentCategory명을 입력해 주세요.",
          content: "40자 이내로 적어주세요.");
      return false;
    }

    if (currentStartDate == null || currentSpan == null) {
      ScreenHelper.alertDialogHandler(context, "프로젝트 기간을 입력해 주세요.");
      return false;
    }

    if (currentDeadline == null) {
      ScreenHelper.alertDialogHandler(context, "마감 기한을 입력해 주세요.");
      return false;
    }

    if (currentProcess == null) {
      ScreenHelper.alertDialogHandler(context, "진행 방식을 선택해 주세요.");
      return false;
    }

    if (currentProcess != "온라인" && currentLocation == null) {
      ScreenHelper.alertDialogHandler(context, "만날 지역을 선택해 주세요.");
      return false;
    }

    for (Pair p in currentPosition) {
      if (p.k == null || p.v == null) {
        ScreenHelper.alertDialogHandler(context, "포지션을 선택해 주세요.");
        return false;
      }
    }

    if (currentTechSkill.isEmpty) {
      ScreenHelper.alertDialogHandler(context, "기술 스택을 선택해 주세요.");
      return false;
    }

    if (currentDeadline!.isBefore(DateTime.now())) {
      ScreenHelper.alertDialogHandler(context, "마감기한을 재선택 해주세요.");
      return false;
    }

    return true;
  }

  void _submit() async {
    if (!_validate()) return;

    final String poster =
        context.read<UserAccountBloc>().state.userAccount.nickname!;

    PartyArticleCreator partyArticleCreateModel = PartyArticleCreator(
        poster: poster,
        category: currentCategory,
        title: _titleController.text,
        description: await _htmlEditorController.getText(),
        techSkill: currentTechSkill,
        position: Helper.pairListToMap<String, int>(currentPosition),
        process: currentProcess!,
        location: currentLocation,
        deadline: Helper.dateToIsoString(currentDeadline!),
        startDate: Helper.dateToIsoString(currentStartDate!),
        span: currentSpan!);

    if (!mounted) return;

    bool isCreated =
        await context.read<PartyApi>().createArticle(partyArticleCreateModel);

    if (isCreated && mounted) {
      ScreenHelper.alertDialogHandler(context, "게시물이 등록되었습니다!", callback: () {
        Helper.pushRemoveScreen(context, const Party());
      });
    }
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: PrimaryBtn(
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
                TitleColumn(
                  title: "유형",
                  child: Row(
                    children: List.generate(
                      category.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ToggleChip(
                            label: category[index],
                            onPressed: () => _setCategory(category[index]),
                            toggle: currentCategory == category[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                TitleColumn(
                  title: "$currentCategory명",
                  child: CreateInput(
                    textEditingController: _titleController,
                    hintText: "40자 이내로 적어주세요.",
                    maxLength: 40,
                  ),
                ),
                TitleColumn(
                  title: "프로젝트 기간",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SecondaryBtn(
                        label: currentStartDate == null
                            ? "시작 날짜"
                            : DateFormat("yy.MM.dd").format(currentStartDate!),
                        onPressed: _setStartDate,
                        widgetSize: WidgetSize.big,
                        width: 160,
                        alignment: Alignment.centerLeft,
                      ),
                      DropdownBtn(
                        items: span,
                        hintText: "기간",
                        onSelected: _setSpan,
                      ),
                    ],
                  ),
                ),
                TitleColumn(
                  title: "마감 기한",
                  child: SecondaryBtn(
                    label: currentDeadline == null
                        ? "마감 날짜"
                        : DateFormat("yy.MM.dd").format(currentDeadline!),
                    onPressed: _setDeadline,
                    widgetSize: WidgetSize.big,
                    width: 160,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                TitleColumn(
                  title: "진행 방식",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownBtn(
                        items: process,
                        onSelected: _setProcess,
                        hintText: "진행 방식",
                      ),
                      if (currentProcess != "온라인")
                        DropdownBtn(
                          items: location,
                          onSelected: _setLocation,
                          hintText: "지역",
                        ),
                    ],
                  ),
                ),
                TitleColumn(
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
                                      DropdownBtn(
                                        items: Helper.deduplicatedList<String>(
                                            position, _selectedPositions()),
                                        hintText: "포지션",
                                        onSelected: (position) =>
                                            _setPosition(index, position),
                                      ),
                                      const SizedBox(
                                        width: 17,
                                      ),
                                      CreateInput(
                                        width: 80,
                                        keyboardType: TextInputType.number,
                                        onChanged: (count) =>
                                            _setPositionCount(index, count),
                                      ),
                                    ],
                                  ),
                                  if (index != 0)
                                    OutlinedButton(
                                      onPressed: () =>
                                          _removePositionRow(index),
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
                          child: PrimaryBtn(
                            label: "추가",
                            onPressed: _addPositionRow,
                            widgetSize: WidgetSize.small,
                            widgetColor: WidgetColor.mint,
                          ),
                        )
                    ],
                  ),
                ),
                TitleColumn(
                  title: "기술 스택",
                  child: Column(
                    children: [
                      Column(
                        children: [
                          CreateInput(
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
                              onPressed: () =>
                                  _addTechSkill(searchedTechSkills[index]),
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
                          spacing: 15,
                          runSpacing: 15,
                          children:
                              List.generate(currentTechSkill.length, (index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/skills/${currentTechSkill[index]}.svg",
                                  width: 30,
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      _removeTechSkill(currentTechSkill[index]),
                                  child: const Icon(
                                    Icons.close,
                                    size: 18,
                                  ),
                                )
                              ],
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                TitleColumn(
                  title: "$currentCategory 설명",
                  child: HtmlEditor(
                    controller: _htmlEditorController,
                    otherOptions: const OtherOptions(
                      height: 400,
                    ),
                    htmlToolbarOptions: const HtmlToolbarOptions(
                      toolbarType: ToolbarType.nativeScrollable,
                      defaultToolbarButtons: [
                        FontButtons(clearAll: false),
                        FontSettingButtons(
                            fontSizeUnit: false, fontName: false),
                        ColorButtons(),
                        ListButtons(listStyles: false),
                        ParagraphButtons(
                          textDirection: false,
                          lineHeight: false,
                          caseConverter: false,
                          increaseIndent: false,
                          decreaseIndent: false,
                        ),
                      ],
                    ),
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
