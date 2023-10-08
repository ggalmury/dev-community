import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/widgets/atoms/buttons/primary_btn.dart';
import 'package:dev_community/widgets/organisms/calendar.dart';
import 'package:flutter/material.dart';

class ScreenHelper {
  static modalBottomSheetHandler(
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

  static alertDialogHandler(BuildContext context,
      {required String title,
      String? content,
      String? label,
      Function? callback}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.transparent,
          child: SizedBox(
            height: 230,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content != null ? Text(content) : const SizedBox(),
                  PrimaryBtn(
                    label: label ?? "확인",
                    onPressed: () => Navigator.pop(context),
                    widgetSize: WidgetSize.big,
                    widgetColor: WidgetColor.black,
                    widgetShape: WidgetShape.square,
                    width: double.infinity,
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      if (callback != null) callback();
    });
  }

  static datePickerHandler(
      BuildContext context, void Function(DateTime) onSelected,
      {DateTime? selectedDate}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Calendar(
            onSelected: onSelected,
            selectedDate: selectedDate,
          ),
        );
      },
    );
  }
}
