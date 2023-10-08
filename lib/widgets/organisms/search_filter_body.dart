import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:dev_community/utils/enums/global.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/widgets/atoms/buttons/primary_btn.dart';
import 'package:dev_community/widgets/atoms/buttons/text_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/screen/party/search_filter_bloc.dart';
import '../atoms/buttons/toggle_btn.dart';

class SearchFilterBody extends StatefulWidget {
  final String label;
  final SearchFilterCategory category;
  final List<String> elements;

  const SearchFilterBody({
    super.key,
    required this.label,
    required this.category,
    required this.elements,
  });

  @override
  State<SearchFilterBody> createState() => _SearchFilterBodyState();
}

class _SearchFilterBodyState extends State<SearchFilterBody> {
  void _dispatchEvent(String data) {
    context
        .read<SearchFilterBloc>()
        .add(SetSearchFilterEvent(category: widget.category, data: data));
  }

  void _dispatchResetEvent() {
    context
        .read<SearchFilterBloc>()
        .add(ResetSearchFilterEvent(category: widget.category));
  }

  void _closeBottomSheet() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 20,
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: CustomStyle.fs18,
                fontWeight: FontWeight.bold,
              ),
            )),
        const Divider(
          height: 30,
          thickness: 0.5,
          color: Colors.grey,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                  spacing: 7,
                  runSpacing: 5,
                  children: List.generate(widget.elements.length, (index) {
                    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
                      builder: (context, state) {
                        return ToggleBtn(
                          label: widget.elements[index],
                          onPressed: () {
                            _dispatchEvent(widget.elements[index]);
                          },
                          widgetColor: WidgetColor.grey,
                          widgetShape: WidgetShape.square,
                          toggle: state.filterMap[widget.category]!
                                  .contains(widget.elements[index])
                              ? true
                              : false,
                        );
                      },
                    );
                  })),
            ),
          ),
        ),
        SizedBox(
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: TextBtn(
                  label: "초기화",
                  onPressed: _dispatchResetEvent,
                  fontSize: CustomStyle.fs16,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: PrimaryBtn(
                  label: "적용",
                  onPressed: _closeBottomSheet,
                  fontSize: CustomStyle.fs16,
                  widgetSize: WidgetSize.big,
                  widgetColor: WidgetColor.purple,
                  widgetShape: WidgetShape.square,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
