import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final void Function(String)? onChanged;
  final double? width;

  const SearchInput(
      {super.key,
      this.textEditingController,
      this.hintText,
      this.onChanged,
      this.width});

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
        style: TextStyle(fontSize: CustomStyle.fs14),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          border: commonBorder,
          focusedBorder: commonBorder,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
