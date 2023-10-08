import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class DropdownBtn extends StatelessWidget {
  final List<String> items;
  final void Function(String?) onSelected;
  final String hintText;
  final double? width;

  const DropdownBtn(
      {super.key,
      required this.items,
      required this.onSelected,
      required this.hintText,
      this.width});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: width ?? 160,
      dropdownMenuEntries: items.map((value) {
        return DropdownMenuEntry(
          value: value,
          label: value,
        );
      }).toList(),
      hintText: hintText,
      menuHeight: 280,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: CustomColor.grey,
            )),
        contentPadding: const EdgeInsets.only(
          left: 20,
        ),
        constraints: const BoxConstraints(
          maxHeight: 45,
        ),
      ),
      onSelected: onSelected,
    );
  }
}
