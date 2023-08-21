import 'package:dev_community/bloc/screen/project/search_filter_bloc.dart';
import 'package:dev_community/utils/enum.dart';
import 'package:dev_community/widgets/atoms/chosen_tag.dart';
import 'package:dev_community/widgets/components/search_filter_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/helpers/screen_helper.dart';
import '../atoms/buttons/button_category.dart';

class SearchFilterRow extends StatefulWidget {
  final String label;
  final SearchFilterCategory category;
  final List<String> elements;

  const SearchFilterRow({
    super.key,
    required this.label,
    required this.category,
    required this.elements,
  });

  @override
  State<SearchFilterRow> createState() => _SearchFilterRowState();
}

class _SearchFilterRowState extends State<SearchFilterRow> {
  void _activateBottomSheet() {
    ScreenHelper().modalBottomSheetHandler(
        context,
        SearchFilterBody(
          label: widget.label,
          category: widget.category,
          elements: widget.elements,
        ),
        470);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonCategory(title: widget.label, onPressed: _activateBottomSheet),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: BlocBuilder<SearchFilterBloc, DefaultSearchFilterState>(
            buildWhen: (previous, current) {
              return previous.filterMap[widget.category]! !=
                  current.filterMap[widget.category]!;
            },
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    state.filterMap[widget.category]!.length,
                    (index) {
                      return ChosenTag(
                        label: state.filterMap[widget.category]![index],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
