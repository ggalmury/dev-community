import 'package:flutter/material.dart';

class ButtonDropdown extends StatelessWidget {
  final List<String> items;
  final void Function(String?) onSelected;
  final String hint;
  final String? value;
  final double? width;
  final double? height;

  const ButtonDropdown(
      {super.key,
      required this.items,
      required this.onSelected,
      required this.hint,
      this.value,
      this.width,
      this.height});

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
      hintText: hint,
      menuHeight: 280,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.only(
          left: 20,
        ),
        constraints: BoxConstraints(
          maxHeight: height ?? 47,
        ),
      ),
      onSelected: onSelected,
    );
  }
}
