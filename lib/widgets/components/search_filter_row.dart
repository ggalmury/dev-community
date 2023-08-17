import 'package:dev_community/bloc/screen/project/project_search_filter_bloc.dart';
import 'package:dev_community/utils/enum.dart';
import 'package:dev_community/widgets/atoms/buttons/searched_filter_chip.dart';
import 'package:dev_community/widgets/components/search_filter_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/helpers/screen_helper.dart';
import '../atoms/buttons/button_category.dart';

class SearchFilterRow<T extends Bloc<dynamic, K>, K> extends StatefulWidget {
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
  State<SearchFilterRow> createState() => _SearchFilterRowState<T, K>();
}

class _SearchFilterRowState<T extends Bloc<dynamic, K>, K>
    extends State<SearchFilterRow> {
  void _activateBottomSheet() {
    ScreenHelper().modalBottomSheetHandler(
        context,
        SearchFilterBody<T, K>(
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
          child: BlocBuilder<T, K>(
            builder: (context, state) {
              List<String> list = [];

              if (state is DefaultProjectSearchFilterState) {
                list = state.filterMap[widget.category]!;
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    list.length,
                    (index) {
                      return SearchedFilterChip(
                        label: list[index],
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
