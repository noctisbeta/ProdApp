import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'event_adding_page.dart';
import 'event.dart';
// import 'package:fl_chart/fl_chart.dart';
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
            Flexible(
              flex: 1,
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
            Flexible(
              flex: 2,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                      SizedBox(width: 10),
                      Text('Sleep')
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.indigoAccent,
          onPressed: () async {
            final data = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventAddingPage(
                        events: widget.events,
                      )),
            );
            setState(() {
              widget.events = data;
            });
          },
        ));
  }
}

class Arcs extends CustomPainter {
  List<Event> events;

  Arcs(List<Event> this.events);

  @override
  void paint(Canvas canvas, Size size) {
    // print(events);
    // print(events.length);
    // print('length');
    // events.add(Event(
    //     from: TimeOfDay(hour: 14, minute: 0),
    //     to: TimeOfDay(hour: 16, minute: 45),
    //     title: 'Ime',
    //     color: Colors.red
    //     ));

    // print(events);
    // print(events.length);
    // print('length pol');

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    // var fillBrush2 = Paint()..color = Color(0xff303030);
    var fillBrush2 = Paint()..color = Colors.indigoAccent;
    Rect rect = Rect.fromCenter(center: center, width: 180, height: 180);

    if (!events.isEmpty) {
      for (int i = 0; i < events.length; i++) {
        var radStart, radEnd;
        var temp = events[i].from;
        var temp2 = events[i].to;
        radStart = temp.hour * pi / 12 + temp.minute * pi / 720 - pi / 2;
        radEnd =
            temp2.hour * pi / 12 + temp2.minute * pi / 720 - pi / 2 - radStart;
        var fillBrush = Paint()..color = events[i].color!;
        canvas.drawArc(rect, radStart, radEnd, true, fillBrush);
      }
    }

    canvas.drawCircle(center, radius, fillBrush2);
    var fillBrush3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;
    canvas.drawCircle(center, radius, fillBrush3);
    canvas.drawCircle(center, size.width - 9, fillBrush3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
