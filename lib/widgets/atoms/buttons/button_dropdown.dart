import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class ButtonDropdown extends StatelessWidget {
  final List<String> items;
  final void Function(dynamic) onChanged;
  final String? value;

  const ButtonDropdown(
      {super.key, required this.items, required this.onChanged, this.value});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: items.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
      hint: value == null ? const Text("선택") : Text(value!),
      onChanged: onChanged,
      dropdownColor: CustomColor.whiteGrey1,
      elevation: 0,
    );
  }
}
