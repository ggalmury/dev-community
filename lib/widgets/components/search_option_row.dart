import 'package:flutter/material.dart';

import '../atoms/buttons/button_option.dart';

class SearchOptionRow extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final List<String> optionList;

  const SearchOptionRow(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.optionList});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonOption(title: title, onPressed: onPressed),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                optionList.length,
                (index) {
                  return Container(
                    width: 50,
                    color: Colors.red,
                    child: Text(optionList[index]),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
