import 'package:dev_community/bloc/screen/party/party_article_create_bloc.dart';
import 'package:dev_community/utils/constant.dart';
import 'package:dev_community/widgets/atoms/buttons/button_dropdown.dart';
import 'package:dev_community/widgets/atoms/inputs/input_create.dart';
import 'package:dev_community/widgets/atoms/toggle_chip.dart';
import 'package:dev_community/widgets/molecules/article_create_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartyArticleCreate extends StatefulWidget {
  const PartyArticleCreate({super.key});

  @override
  State<PartyArticleCreate> createState() => _PartyArticleCreateState();
}

class _PartyArticleCreateState extends State<PartyArticleCreate> {
  final TextEditingController _titleController = TextEditingController();

  void _setType(String type) {
    context
        .read<PartyArticleCreateBloc>()
        .add(SetPartyArticleCreateTypeEvent(type: type));
  }

  void _setProcess(dynamic process) {
    context
        .read<PartyArticleCreateBloc>()
        .add(SetPartyArticleCreateProcessEvent(process: process));
  }

  void _setLocation(dynamic location) {
    context
        .read<PartyArticleCreateBloc>()
        .add(SetPartyArticleCreateLocationEvent(location: location));
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
                          child: BlocBuilder<PartyArticleCreateBloc,
                              PartyArticleCreateState>(
                            builder: (context, state) {
                              return ToggleChip(
                                label: type[index],
                                onPressed: () {
                                  _setType(type[index]);
                                },
                                toggle: state.partyArticleCreateModel.type ==
                                    type[index],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<PartyArticleCreateBloc, PartyArticleCreateState>(
                  builder: (context, state) {
                    return ArticleCreateColumn(
                      title: "${state.partyArticleCreateModel.type}명",
                      child: InputCreate(
                        textEditingController: _titleController,
                        hintText: "40자 이내로 적어주세요.",
                        maxLength: 40,
                      ),
                    );
                  },
                ),
                BlocBuilder<PartyArticleCreateBloc, PartyArticleCreateState>(
                  builder: (context, state) {
                    return ArticleCreateColumn(
                      title: "진행방식",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonDropdown(
                            items: process,
                            onChanged: _setProcess,
                            value: state.partyArticleCreateModel.process,
                            label: "진행 방식",
                            width: 150,
                          ),
                          if (state.partyArticleCreateModel.process == "온라인" ||
                              state.partyArticleCreateModel.process == "온/오프라인")
                            ButtonDropdown(
                              items: location,
                              onChanged: _setLocation,
                              value: state.partyArticleCreateModel.location,
                              label: "지역",
                              width: 180,
                            ),
                        ],
                      ),
                    );
                  },
                ),
                OutlinedButton(
                  onPressed: () {
                    context.read<PartyArticleCreateBloc>().add(
                        SubmitPartyArticleCreateEvent(
                            title: _titleController.text));
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
