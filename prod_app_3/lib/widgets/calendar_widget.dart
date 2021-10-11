import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:developer';
import '../screens/day_summary_screen.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        cellBorderColor: Colors.transparent,
        onLongPress: (CalendarLongPressDetails dayInfo) =>
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => DaySummaryScreen(dayInfo: dayInfo)),
            ));
  }
}
