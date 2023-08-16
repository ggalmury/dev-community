import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/enum.dart';
import '../atoms/buttons/search_filter_chip.dart';

class SearchFilterBody<T extends Bloc> extends StatelessWidget {
  final SearchFilterCategory category;
  final String label;
  final List<String> list;
  final void Function(SearchFilterCategory, String) onChipPressed;

  const SearchFilterBody(
      {super.key,
      required this.category,
      required this.label,
      required this.list,
      required this.onChipPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 30,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
        const Divider(
          height: 10,
          thickness: 0.5,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
                spacing: 7,
                runSpacing: 5,
                children: List.generate(list.length, (index) {
                  return SearchFilterChip(
                    title: list[index],
                    onPressed: () {
                      onChipPressed(category, list[index]);
                    },
                  );
                })),
          ),
        ),
        const SizedBox(
            height: 100,
            child: Center(
              child: Text("버튼 자리"),
            )),
      ],
    );
  }
}
