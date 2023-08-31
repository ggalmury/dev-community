import 'package:flutter/material.dart';

class ScreenHelper {
  void modalBottomSheetHandler(
      BuildContext context, Widget content, double height) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext ctx) {
        return SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: content,
          ),
        );
      },
    );
  }

  Future<DateTime?> datePickerHandler(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('ko', 'KR'),
    );

    return date;
  }
}
