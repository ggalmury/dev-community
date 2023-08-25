import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class InputCreate extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final int? maxLength;

  const InputCreate(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: CustomColor.grey,
      ),
    );

    return TextField(
      controller: textEditingController,
      maxLength: maxLength,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: commonBorder,
        focusedBorder: commonBorder,
      ),
    );
  }
}