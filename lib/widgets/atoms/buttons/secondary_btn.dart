import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:flutter/material.dart';

class SecondaryBtn extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final WidgetSize widgetSize;
  final double? width;
  final double? fontSize;
  final Alignment? alignment;

  const SecondaryBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.widgetSize,
      this.width,
      this.fontSize,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: widgetSize == WidgetSize.big ? 45 : 35,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          alignment: alignment,
          side: const BorderSide(
            color: CustomColor.greyHeavy,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
