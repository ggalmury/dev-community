import 'package:dev_community/bloc/screen/project/project_search_filter_bloc.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../atoms/buttons/button_category.dart';

class SearchFilterRow<T extends StateStreamable<K>, K> extends StatelessWidget {
  final String label;
  final SearchFilterCategory category;
  final void Function() onPressed;

  const SearchFilterRow({
    super.key,
    required this.label,
    required this.category,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonCategory(title: label, onPressed: onPressed),
        Expanded(
          child: BlocBuilder<T, K>(
            builder: (context, state) {
              List<String> list = [];

              if (state is DefaultProjectSearchFilterState) {
                list = state.filterMap[category]!;
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    list.length,
                    (index) {
                      return Container(
                        width: 50,
                        color: CustomColor.whiteGrey2,
                        child: Center(child: Text(list[index])),
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
