import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/widgets/atoms/buttons/button_submit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/screen/project/project_search_filter_bloc.dart';
import '../../utils/enum.dart';
import '../atoms/buttons/search_filter_chip.dart';

class SearchFilterBody<T extends Bloc<dynamic, K>, K> extends StatefulWidget {
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
  State<SearchFilterBody> createState() => _SearchFilterBodyState<T, K>();
}

class _SearchFilterBodyState<T extends Bloc<dynamic, K>, K>
    extends State<SearchFilterBody> {
  void _dispatchEvent(String data) {
    dynamic event;

    if (T == ProjectSearchFilterBloc) {
      event =
          SetProjectSearchFilterEvent(category: widget.category, data: data);
    } else {
      return;
    }

    context.read<T>().add(event);
  }

  void _dispatchResetEvent() {
    dynamic event;

    if (T == ProjectSearchFilterBloc) {
      event = ResetProjectSearchFilterEvent(category: widget.category);
    } else {
      return;
    }

    context.read<T>().add(event);
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
            child: Wrap(
                spacing: 7,
                runSpacing: 5,
                children: List.generate(widget.elements.length, (index) {
                  return SearchFilterChip<T, K>(
                    label: widget.elements[index],
                    category: widget.category,
                    onPressed: () {
                      _dispatchEvent(widget.elements[index]);
                    },
                  );
                })),
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
