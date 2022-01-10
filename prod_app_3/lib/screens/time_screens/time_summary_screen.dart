import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prod_app_3/database/database.dart';

import '../../database/time_event.dart';
import 'time_adding_screen.dart';

class TimeSummaryScreen extends StatefulWidget {
  final DateTime dateTime;

  const TimeSummaryScreen({required this.dateTime, Key? key}) : super(key: key);

  @override
  _TimeSummaryScreenState createState() => _TimeSummaryScreenState();
}

class _TimeSummaryScreenState extends State<TimeSummaryScreen> {
  Future<List<TimeEvent>> getEvents() async {
    return DatabaseHelper.instance.getTimeEvents(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TimeEvent>>(
        future: getEvents(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<TimeEvent>> snapshot,
        ) {
          if (snapshot.hasError) {
            return const Text('has error');
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CustomPaint(
                        painter: CircleFramePainter(),
                      ),
                    ),
                    if (snapshot.hasData && snapshot.data!.isNotEmpty)
                      ...fixedEvents(snapshot.data!).map(
                        (e) => Arc(
                          event: e,
                        ),
                      ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CustomPaint(
                        painter: TimePointerPainter(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      if (snapshot.hasData && snapshot.data!.isNotEmpty)
                        // ...snapshot.data!.map((e) => LegendEntry(event: e))
                        ...getLegend(snapshot.data!),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () async {
          final List<TimeEvent> events = await getEvents();
          if (!mounted) return;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TimeAddingPage(
                  selectedDate: widget.dateTime,
                  events: events,
                );
              },
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

List<TimeEvent> fixedEvents(List<TimeEvent> events) {
  // final List<TimeEvent> fixedList = [];
  final List<TimeEvent> events2 = events;
  // final Map<TimeEvent, TimeEvent> sosednji = {};

  for (int k = 0; k < events2.length; k++) {
    for (int i = 0; i < events2.length; i++) {
      for (int j = i + 1; j < events2.length; j++) {
        if (events2[i].title == events2[j].title &&
            (events2[i].to == events2[j].from)) {
          final TimeEvent ei = events2[i];
          final TimeEvent ej = events2[j];
          final TimeEvent newEvent = TimeEvent(
            color: events2[i].color,
            title: events2[i].title,
            from: events2[i].from,
            to: events2[j].to,
            dateTime: events2[i].dateTime,
          );
          events2.add(newEvent);
          events2.remove(ei);
          events2.remove(ej);
        } else if (events2[i].title == events2[j].title &&
            events2[j].to == events2[i].from) {
          final TimeEvent ei = events2[i];
          final TimeEvent ej = events2[j];
          final TimeEvent newEvent = TimeEvent(
            color: events2[i].color,
            title: events2[i].title,
            from: events2[j].from,
            to: events2[i].to,
            dateTime: events2[i].dateTime,
          );
          events2.add(newEvent);
          events2.remove(ei);
          events2.remove(ej);
        }
      }
    }
  }

  return events2;
}

List<Widget> getLegend(List<TimeEvent> events) {
  final Map<String, TimeEvent> nameEvent = {};

  for (final e in events) {
    nameEvent.putIfAbsent(e.title, () => e);
  }

  return nameEvent.values.map((e) => LegendEntry(event: e)).toList();
}

class LegendEntry extends StatelessWidget {
  const LegendEntry({
    Key? key,
    required this.event,
  }) : super(key: key);

  final TimeEvent event;

  @override
  Widget build(BuildContext context) {
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

class CircleFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Path path = Path();

    const double rectSize = 141;
    final Rect rect =
        Rect.fromCenter(center: center, width: rectSize, height: rectSize);

    final Paint fillBrush = Paint()
      ..color = Colors.pink[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40;

    path.arcTo(rect, 0, -(2 * pi - 1), true);
    canvas.drawPath(path, fillBrush);
    path.reset();
    path.arcTo(rect, 0, 1, true);
    canvas.drawPath(path, fillBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TimePointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY);

    final Paint fillBrush4 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;

    final Paint fillBrush5 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.black;

    final DateTime currentTime = DateTime.now();

    final double currentTimeAngle =
        currentTime.hour * pi / 12 + currentTime.minute * pi / 720 - pi / 2;

    final double hourX = centerX + cos(currentTimeAngle) * radius;
    final double hourY = centerY + sin(currentTimeAngle) * radius;
    final double hourXe = centerX + cos(currentTimeAngle) * 89;
    final double hourYe = centerX + sin(currentTimeAngle) * 89;

    canvas.drawLine(Offset(hourX, hourY), Offset(hourXe, hourYe), fillBrush4);
    canvas.drawCircle(Offset(hourXe, hourYe), 3, fillBrush5);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcPainter extends CustomPainter {
  final TimeEvent event;
  final Path path = Path();

  ArcPainter({
    required this.event,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);

    const double rectSize = 141;

    double radStart;
    double radEnd;
    final TimeOfDay from = event.from;
    final TimeOfDay to = event.to;
    radStart = from.hour * pi / 12 + from.minute * pi / 720 - pi / 2;
    radEnd = to.hour * pi / 12 + to.minute * pi / 720 - pi / 2 - radStart;
    if (to.hour == 0) {
      radEnd = 2 * pi - radStart - pi / 2;
    }
    final fillBrush = Paint()
      ..color = event.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40;

    final Rect rect =
        Rect.fromCenter(center: center, width: rectSize, height: rectSize);

    canvas.drawArc(
      rect,
      radStart,
      radEnd,
      false,
      fillBrush,
    );

    path.reset();
    path.moveTo(centerX, centerY);
    const double radius = 92;
    path.lineTo(
      centerX + radius * cos(radStart),
      centerY + radius * sin(radStart),
    );
    final brush = Paint()
      ..color = const Color(0xFFF2AEB4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawPath(path, brush);

    path.reset();
    path.moveTo(centerX, centerY);
    path.lineTo(
      centerX + radius * cos(radEnd + radStart),
      centerY + radius * sin(radEnd + radStart),
    );
    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Arc extends StatefulWidget {
  final TimeEvent event;
  const Arc({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  _ArcState createState() => _ArcState();
}

class _ArcState extends State<Arc> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: CustomPaint(
        painter: ArcPainter(
          event: widget.event,
        ),
      ),
    );
  }
}
