import 'package:flutter/material.dart';

class ScreenHelper {
  void modalBottomSheetHandler(
      BuildContext context, Widget content, double height) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
}
