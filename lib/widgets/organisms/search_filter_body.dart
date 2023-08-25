import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/widgets/atoms/buttons/button_submit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/screen/project/search_filter_bloc.dart';
import '../../utils/enum.dart';
import '../atoms/toggle_chip.dart';

class SearchFilterBody extends StatefulWidget {
  final String label;
  final SearchFilterCategory category;
  final List<String> elements;

  const SearchFilterBody({
    super.key,
    required this.label,
    required this.category,
    required this.elements,
  });

  @override
  State<SearchFilterBody> createState() => _SearchFilterBodyState();
}

class _SearchFilterBodyState extends State<SearchFilterBody> {
  void _dispatchEvent(String data) {
    context
        .read<SearchFilterBloc>()
        .add(SetSearchFilterEvent(category: widget.category, data: data));
  }

  void _dispatchResetEvent() {
    context
        .read<SearchFilterBloc>()
        .add(ResetSearchFilterEvent(category: widget.category));
  }

  void _closeBottomSheet() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 20,
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
        const Divider(
          height: 30,
          thickness: 0.5,
          color: Colors.grey,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                  spacing: 7,
                  runSpacing: 5,
                  children: List.generate(widget.elements.length, (index) {
                    return BlocBuilder<SearchFilterBloc,
                        DefaultSearchFilterState>(
                      builder: (context, state) {
                        return ToggleChip(
                          label: widget.elements[index],
                          category: widget.category,
                          onPressed: () {
                            _dispatchEvent(widget.elements[index]);
                          },
                          toggle: state.filterMap[widget.category]!
                                  .contains(widget.elements[index])
                              ? true
                              : false,
                        );
                      },
                    );
                  })),
            ),
          ),
        ),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonSubmit(
                label: "초기화",
                onPressed: _dispatchResetEvent,
                width: 100,
                height: 45,
                fontSize: 16,
              ),
              const SizedBox(
                width: 20,
              ),
              ButtonSubmit(
                label: "적용",
                onPressed: _closeBottomSheet,
                width: 170,
                height: 45,
                backgroundColor: CustomColor.mint,
                foregroundColor: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
