import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class ButtonDropdown extends StatelessWidget {
  final List<String> items;
  final void Function(dynamic) onChanged;
  final String label;
  final String? value;
  final double? width;

  const ButtonDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.label,
      this.value,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CustomColor.grey,
        ),
      ),
      child: DropdownButton(
        items: items.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        hint: Text(value == null ? label : value!),
        isExpanded: width != null ? true : false,
        alignment: Alignment.center,
        onChanged: onChanged,
        underline: const SizedBox(),
        menuMaxHeight: 280,
        dropdownColor: CustomColor.whiteGrey1,
        elevation: 0,
      ),
    );
  }
}
