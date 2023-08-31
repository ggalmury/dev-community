import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class CreateInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final void Function(String)? onChanged;
  final double? width;
  final int? maxLength;
  final TextInputType? keyboardType;

  const CreateInput({
    super.key,
    this.textEditingController,
    this.hintText,
    this.onChanged,
    this.width,
    this.maxLength,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: CustomColor.grey,
      ),
    );

    return SizedBox(
      width: width,
      child: TextField(
        controller: textEditingController,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: commonBorder,
          focusedBorder: commonBorder,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
