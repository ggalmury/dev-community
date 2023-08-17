import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/screen/project/project_search_filter_bloc.dart';
import '../../../utils/enum.dart';

class SearchFilterChip<T extends Bloc<dynamic, K>, K> extends StatefulWidget {
  final String label;
  final SearchFilterCategory category;
  final void Function() onPressed;

  const SearchFilterChip(
      {super.key,
      required this.label,
      required this.category,
      required this.onPressed});

  @override
  State<SearchFilterChip> createState() => _SearchFilterChipState<T, K>();
}

class _SearchFilterChipState<T extends Bloc<dynamic, K>, K>
    extends State<SearchFilterChip> {
  bool _setToggle(List<String> list) {
    return list.contains(widget.label) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, K>(
      builder: (context, state) {
        bool toggle = false;

        if (state is DefaultProjectSearchFilterState) {
          toggle = _setToggle(state.filterMap[widget.category]!);
        }

        return OutlinedButton(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: toggle ? Colors.transparent : CustomColor.whiteGrey2,
              width: 1,
            ),
            backgroundColor: toggle ? CustomColor.whiteGrey1 : Colors.white,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: toggle ? Colors.black : CustomColor.grey,
            ),
          ),
        );
      },
    );
  }
}
