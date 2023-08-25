import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class ToggleChip extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final bool? toggle;

  const ToggleChip(
      {super.key, required this.label, required this.onPressed, this.toggle});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          color: toggle == true ? Colors.transparent : CustomColor.whiteGrey2,
          width: 1,
        ),
        backgroundColor: toggle == true ? CustomColor.whiteGrey1 : Colors.white,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: toggle == true ? Colors.black : CustomColor.grey,
        ),
      ),
    );
  }
}
