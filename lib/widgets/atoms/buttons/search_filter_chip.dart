import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class SearchFilterChip extends StatefulWidget {
  final String title;
  final void Function() onPressed;

  const SearchFilterChip(
      {super.key, required this.title, required this.onPressed});

  @override
  State<SearchFilterChip> createState() => _SearchFilterChipState();
}

class _SearchFilterChipState extends State<SearchFilterChip> {
  bool toggle = false;

  void onToggle() {
    setState(() {
      toggle = !toggle;
    });

    widget.onPressed();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onToggle,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: toggle ? Colors.transparent : CustomColor.whiteGrey2,
            width: 1,
          ),
          backgroundColor: toggle ? CustomColor.whiteGrey1 : Colors.white,
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: toggle ? Colors.black : CustomColor.grey,
          ),
        ));
  }
}
