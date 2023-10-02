import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final WidgetSize widgetSize;
  final WidgetColor widgetColor;
  final double? width;
  final double? fontSize;

  const PrimaryBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.widgetSize,
      required this.widgetColor,
      this.width,
      this.fontSize});

  Color? _backgroundColor() {
    Color? color;

    switch (widgetColor) {
      case WidgetColor.black:
        color = CustomColor.black;
        break;
      case WidgetColor.white:
        color = Colors.white;
        break;
      case WidgetColor.grey:
        color = CustomColor.whiteGrey2;
        break;
      default:
        break;
    }

    return color;
  }

  Color? _foregroundColor() {
    Color? color;

    switch (widgetColor) {
      case WidgetColor.black:
        color = Colors.white;
        break;
      case WidgetColor.white:
        color = Colors.black;
        break;
      case WidgetColor.grey:
        color = Colors.black;
        break;
      default:
        break;
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: widgetSize == WidgetSize.big ? 45 : 35,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: _backgroundColor(),
          foregroundColor: _foregroundColor(),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
