import 'package:flutter/material.dart';

class ScreenHelper {
  void modaBottomSheetHandler(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const SizedBox(
          height: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("bottomSheet"),
          ),
        );
      },
    );
  }
}
