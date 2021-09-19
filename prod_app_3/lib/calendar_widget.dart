import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:developer';
import 'day_summary.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        cellBorderColor: Colors.transparent,
        // onTap: (CalendarTapDetails a) => {log('a')},
        onLongPress: (CalendarLongPressDetails dayInfo) =>
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DaySummary(dayInfo)),
            ));
  }
}
