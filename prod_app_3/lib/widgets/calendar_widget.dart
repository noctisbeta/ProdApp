import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:developer';
import '../screens/time_screens/time_summary_screen.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      headerStyle: const CalendarHeaderStyle(
        textAlign: TextAlign.center,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      monthViewSettings: const MonthViewSettings(
        monthCellStyle: MonthCellStyle(
          textStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      backgroundColor: Colors.grey[800],
      onLongPress: (CalendarLongPressDetails dayInfo) =>
          Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TimeSummaryScreen(dateTime: dayInfo.date!),
        ),
      ),
    );
  }
}
