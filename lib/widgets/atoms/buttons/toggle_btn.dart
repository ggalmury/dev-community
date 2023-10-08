import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:flutter/material.dart';

class ToggleBtn extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final WidgetColor widgetColor;
  final WidgetShape widgetShape;
  final bool? toggle;

  const ToggleBtn({
    super.key,
    required this.label,
    required this.onPressed,
    required this.widgetColor,
    required this.widgetShape,
    this.toggle,
  });

  Color? _backgroundColor() {
    Color? color;

    switch (widgetColor) {
      case WidgetColor.black:
        color = CustomColor.black;
        break;
      case WidgetColor.grey:
        color = CustomColor.greyLight;
        break;
      case WidgetColor.purple:
        color = CustomColor.purple;
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
      case WidgetColor.grey:
        color = Colors.black;
        break;
      case WidgetColor.purple:
        color = color = Colors.white;
      default:
        break;
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              widgetShape == WidgetShape.square ? 10 : 20),
        ),
        side: BorderSide(
          color: toggle == true ? Colors.transparent : CustomColor.greyLight,
          width: 1,
        ),
        backgroundColor: toggle == true ? _backgroundColor() : Colors.white,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: toggle == true ? _foregroundColor() : CustomColor.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
