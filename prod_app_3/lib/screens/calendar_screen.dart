import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';

// TODO: Provider za day info

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: CalendarWidget(),
    );
  }
}
