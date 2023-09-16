import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/widgets/atoms/buttons/primary_btn.dart';
import 'package:flutter/material.dart';

class ScreenHelper {
  static void modalBottomSheetHandler(
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

  static void alertDialogHandler(BuildContext context, String title,
      {String? content, String? label, Function? onPressed}) {
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
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
                        onPressed: () {
                          if (onPressed != null) onPressed();
                          Navigator.pop(context);
                        },
                        widgetSize: WidgetSize.big,
                        widgetColor: WidgetColor.mint,
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      if (onPressed != null) onPressed();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<DateTime?> datePickerHandler(BuildContext context) async {
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
