import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'event_adding_page.dart';
import 'event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class DaySummary extends StatefulWidget {
  final CalendarLongPressDetails dayInfo;
  List<Event> events = [];

  DaySummary({Key? key, required CalendarLongPressDetails this.dayInfo})
      : super(key: key);

  @override
  _DaySummaryState createState() => _DaySummaryState();
}

class _DaySummaryState extends State<DaySummary> {
  @override
  Widget build(BuildContext context) {
    // print(Theme.of(context).canvasColor);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              DateFormat('EEEE').format(widget.dayInfo.date!) + '\'s Summary'),
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                child: Container(
                  width: 100,
                  height: 100,
                  child: CustomPaint(
                    painter: Arcs(widget.events),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 50),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
              ),
            ),
            Text('PLACEHOLDER'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.indigoAccent,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => EventAddingPage(
                      events: widget.events,
                    )),
          ),
        ));
  }
}

class Arcs extends CustomPainter {
  List<Event> events;

  Arcs(List<Event> this.events);

  @override
  void paint(Canvas canvas, Size size) {
    print(events);
    events.add(Event(
        from: TimeOfDay(hour: 0, minute: 0),
        to: TimeOfDay(hour: 12, minute: 0),
        title: 'Ime'));

    print(events[0]);
    var radStart, radEnd;
    var temp = events[0].from;
    var temp2 = events[0].to;
    radStart = temp.hour * pi / 8 + temp.minute * pi / 720 - pi / 2;
    radEnd = temp2.hour * pi / 8 + temp2.minute * pi / 720 - pi / 2;

    print(radStart * 180 / pi);
    print(radEnd * 180 / pi);

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Colors.pinkAccent;
    // var fillBrush2 = Paint()..color = Color(0xff303030);
    var fillBrush2 = Paint()..color = Colors.indigoAccent;

    Rect rect = Rect.fromCenter(center: center, width: 180, height: 180);

    canvas.drawArc(rect, radStart, radEnd, true, fillBrush);
    canvas.drawCircle(center, radius, fillBrush2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
