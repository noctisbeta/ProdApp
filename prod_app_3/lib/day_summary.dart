import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'event.dart';
import 'event_adding_page.dart';
import 'globals.dart';

// import 'package:fl_chart/fl_chart.dart';

class DaySummary extends StatefulWidget {
  final CalendarLongPressDetails dayInfo;

  const DaySummary({Key? key, required this.dayInfo}) : super(key: key);

  @override
  _DaySummaryState createState() => _DaySummaryState();
}

class _DaySummaryState extends State<DaySummary> {
  late List<Event> events;

  @override
  void initState() {
    if (dateEventPairs.containsKey(widget.dayInfo.date)) {
      events = dateEventPairs[widget.dayInfo.date]!;
    } else {
      events = <Event>[];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(Theme.of(context).canvasColor);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              "${DateFormat('EEEE').format(widget.dayInfo.date!)}'s Summary"),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: Arcs(events),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: toWidgetList(),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigoAccent,
          onPressed: () async {
            final data = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventAddingPage(
                        events: events,
                      )),
            );
            setState(() {
              events = data as List<Event>;

              if (events.isNotEmpty) {
                dateEventPairs[widget.dayInfo.date!] = events;
              }
            });
          },
          child: const Icon(Icons.add, color: Colors.white),
        ));
  }

  List<Widget> toWidgetList() {
    if (events.isNotEmpty) {
      final List<Widget> list = <Widget>[];
      for (int i = 0; i < events.length; i++) {
        list.add(legendEntry(events[i]));
      }
      return list;
    } else {
      return [];
    }
  }

  Widget legend() {
    if (events.isNotEmpty) {
      return legendEntry(events[0]);
    } else {
      return const Text('empty');
    }
  }

  Widget legendEntry(Event event) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: event.color),
          ),
          const SizedBox(width: 10),
          Text(event.title)
        ],
      ),
    );
  }
}

class Arcs extends CustomPainter {
  List<Event> events;

  Arcs(this.events);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    // var fillBrush2 = Paint()..color = Color(0xff303030);
    final fillBrush2 = Paint()..color = Colors.indigoAccent;
    final Rect rect = Rect.fromCenter(center: center, width: 180, height: 180);

    if (events.isNotEmpty) {
      for (int i = 0; i < events.length; i++) {
        double radStart;
        double radEnd;
        final temp = events[i].from;
        final temp2 = events[i].to;
        radStart = temp.hour * pi / 12 + temp.minute * pi / 720 - pi / 2;
        radEnd =
            temp2.hour * pi / 12 + temp2.minute * pi / 720 - pi / 2 - radStart;
        if (temp2.hour == 0) {
          radEnd = 2 * pi - radStart - pi / 2;
        }
        final fillBrush = Paint()..color = events[i].color!;
        canvas.drawArc(rect, radStart, radEnd, true, fillBrush);
      }
    }

    canvas.drawCircle(center, radius, fillBrush2);
    final fillBrush3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;
    canvas.drawCircle(center, radius, fillBrush3);
    canvas.drawCircle(center, size.width - 8.8, fillBrush3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
