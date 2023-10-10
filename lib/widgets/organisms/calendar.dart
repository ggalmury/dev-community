import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final void Function(DateTime) onSelected;
  final DateTime? selectedDate;

  const Calendar({super.key, required this.onSelected, this.selectedDate});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  void _onDatSelected(DateTime sd, DateTime fd) {
    widget.onSelected(sd);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TableCalendar(
          locale: 'ko-KR',
          focusedDay: widget.selectedDate ?? DateTime.now(),
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(2050, 1, 1),
          selectedDayPredicate: (day) {
            return isSameDay(widget.selectedDate, day);
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: const CalendarStyle(),
          onDaySelected: _onDatSelected,
        ),
      ),
    );
  }
}
