import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';

class NonBorderInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final void Function(String)? onChanged;
  final double? width;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;

  const NonBorderInput({
    super.key,
    this.textEditingController,
    this.hintText,
    this.onChanged,
    this.width,
    this.maxLength,
    this.keyboardType,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: textEditingController,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: TextStyle(
          fontSize: CustomStyle.fs14,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          prefixIcon: prefixIcon,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
