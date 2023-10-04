import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;

  const SearchInput(
      {super.key, required this.textEditingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      style: TextStyle(fontSize: CustomStyle.fs14),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: CustomColor.whiteGrey1,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
