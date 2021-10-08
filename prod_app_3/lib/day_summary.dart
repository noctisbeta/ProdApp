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

  const DaySummary(this.dayInfo, {Key? key}) : super(key: key);

  @override
  _DaySummaryState createState() => _DaySummaryState();
}

class _DaySummaryState extends State<DaySummary> {
  late List<Event> events;
  List<Arc>? arcs = [];
  List<Widget>? arcsDisplay = [];

  @override
  void initState() {
    if (dateEventPairs.containsKey(widget.dayInfo.date)) {
      events = dateEventPairs[widget.dayInfo.date]!;
    } else {
      events = <Event>[];
    }
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        buildArcs();
      });
    });
    super.initState();
  }

  void buildArcs() {
    if (events.isNotEmpty) {
      for (int i = 0; i < events.length; i++) {
        arcs?.add(Arc(events[i]));
        arcsDisplay?.add(SizedBox(
          height: 100,
          width: 100,
          child: Arc(events[i]),
        ));
      }
    }
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Stack(children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CustomPaint(
                      painter: CircleFramePainter(),
                    ),
                  ),
                  ...?arcsDisplay,
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CustomPaint(
                      painter: TimePointerPainter(),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: toWidgetList(),
                ),
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
              if (data == null) {
                return;
              }
              events = data as List<Event>;

              if (events.isNotEmpty) {
                dateEventPairs[widget.dayInfo.date!] = events;
              }
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                setState(() {
                  buildArcs();
                });
              });
            });
          },
          child: const Icon(Icons.add, color: Colors.white),
        ));
  }

  List<Widget> toWidgetList() {
    if (events.isNotEmpty) {
      final List<Widget> list = <Widget>[];
      final List<String> titles = <String>[];
      for (int i = 0; i < events.length; i++) {
        if (!titles.contains(events[i].title)) {
          titles.add(events[i].title);
          list.add(legendEntry(events[i]));
        }
      }
      return list;
    } else {
      return [];
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

// class Arcs extends CustomPainter {
//   List<Event> events;

//   Arcs(this.events);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final centerX = size.width / 2;
//     final centerY = size.height / 2;
//     final center = Offset(centerX, centerY);
//     final radius = min(centerX, centerY);

//     // var fillBrush2 = Paint()..color = Color(0xff303030);
//     final fillBrush2 = Paint()..color = Colors.indigoAccent;
//     final Rect rect = Rect.fromCenter(center: center, width: 180, height: 180);

//     if (events.isNotEmpty) {
//       for (int i = 0; i < events.length; i++) {
//         double radStart;
//         double radEnd;
//         final temp = events[i].from;
//         final temp2 = events[i].to;
//         radStart = temp.hour * pi / 12 + temp.minute * pi / 720 - pi / 2;
//         radEnd =
//             temp2.hour * pi / 12 + temp2.minute * pi / 720 - pi / 2 - radStart;
//         if (temp2.hour == 0) {
//           radEnd = 2 * pi - radStart - pi / 2;
//         }
//         final fillBrush = Paint()..color = events[i].color!;
//         canvas.drawArc(rect, radStart, radEnd, true, fillBrush);
//       }
//     }

//     canvas.drawCircle(center, radius, fillBrush2);
//     final fillBrush3 = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2
//       ..color = Colors.black;
//     canvas.drawCircle(center, radius, fillBrush3);
//     canvas.drawCircle(center, size.width - 8.8, fillBrush3);

//     final fillBrush4 = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2
//       ..color = Colors.black;

//     final fillBrush5 = Paint()
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 2
//       ..color = Colors.black;

//     final currentTime = DateTime.now();
//     // print(currentTime.hour);
//     final currentTimeAngle =
//         currentTime.hour * pi / 12 + currentTime.minute * pi / 720 - pi / 2;
//     // canvas.translate(centerX, centerY);
//     // canvas.rotate(currentTimeAngle);
//     final hourX = centerX + cos(currentTimeAngle) * radius;
//     final hourY = centerY + sin(currentTimeAngle) * radius;
//     final hourXe = centerX + cos(currentTimeAngle) * 89;
//     final hourYe = centerX + sin(currentTimeAngle) * 89;

//     canvas.drawLine(Offset(hourX, hourY), Offset(hourXe, hourYe), fillBrush4);
//     canvas.drawCircle(Offset(hourXe, hourYe), 3, fillBrush5);

//     // canvas.drawArc(rect, currentTimeAngle, currentTimeAngle, true, fillBrush4);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

class CircleFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    // var fillBrush2 = Paint()..color = Color(0xff303030);
    final fillBrush2 = Paint()..color = Colors.indigoAccent;
    canvas.drawCircle(center, radius, fillBrush2);

    final fillBrush3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;
    canvas.drawCircle(center, radius, fillBrush3);
    canvas.drawCircle(center, size.width - 8.8, fillBrush3);

    // final fillBrush4 = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2
    //   ..color = Colors.black;

    // final fillBrush5 = Paint()
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 2
    //   ..color = Colors.black;

    // final currentTime = DateTime.now();
    // // print(currentTime.hour);
    // final currentTimeAngle =
    //     currentTime.hour * pi / 12 + currentTime.minute * pi / 720 - pi / 2;
    // // canvas.translate(centerX, centerY);
    // // canvas.rotate(currentTimeAngle);
    // final hourX = centerX + cos(currentTimeAngle) * radius;
    // final hourY = centerY + sin(currentTimeAngle) * radius;
    // final hourXe = centerX + cos(currentTimeAngle) * 89;
    // final hourYe = centerX + sin(currentTimeAngle) * 89;

    // // canvas.drawLine(Offset(hourX, hourY), Offset(hourXe, hourYe), fillBrush4);
    // canvas.drawCircle(Offset(hourXe, hourYe), 3, fillBrush5);

    // canvas.drawArc(rect, currentTimeAngle, currentTimeAngle, true, fillBrush4);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TimePointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    // var fillBrush2 = Paint()..color = Color(0xff303030);
    // final fillBrush2 = Paint()..color = Colors.indigoAccent;
    // canvas.drawCircle(center, radius, fillBrush2);

    // final fillBrush3 = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2
    //   ..color = Colors.black;
    // canvas.drawCircle(center, radius, fillBrush3);
    // canvas.drawCircle(center, size.width - 8.8, fillBrush3);

    final fillBrush4 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;

    final fillBrush5 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.black;

    final currentTime = DateTime.now();
    // print(currentTime.hour);
    final currentTimeAngle =
        currentTime.hour * pi / 12 + currentTime.minute * pi / 720 - pi / 2;
    // canvas.translate(centerX, centerY);
    // canvas.rotate(currentTimeAngle);
    final hourX = centerX + cos(currentTimeAngle) * radius;
    final hourY = centerY + sin(currentTimeAngle) * radius;
    final hourXe = centerX + cos(currentTimeAngle) * 89;
    final hourYe = centerX + sin(currentTimeAngle) * 89;

    canvas.drawLine(Offset(hourX, hourY), Offset(hourXe, hourYe), fillBrush4);
    canvas.drawCircle(Offset(hourXe, hourYe), 3, fillBrush5);

    // canvas.drawArc(rect, currentTimeAngle, currentTimeAngle, true, fillBrush4);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcPainter extends CustomPainter {
  Event? event;
  final Path path = Path();

  ArcPainter(this.event);

  @override
  bool hitTest(Offset position) {
    final bool hit = path.contains(position);
    return hit;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);

    const double rectSize = 141;
    final Rect rect =
        Rect.fromCenter(center: center, width: rectSize, height: rectSize);

    if (event != null) {
      double radStart;
      double radEnd;
      final temp = event!.from;
      final temp2 = event!.to;
      radStart = temp.hour * pi / 12 + temp.minute * pi / 720 - pi / 2;
      radEnd =
          temp2.hour * pi / 12 + temp2.minute * pi / 720 - pi / 2 - radStart;
      if (temp2.hour == 0) {
        radEnd = 2 * pi - radStart - pi / 2;
      }
      final fillBrush = Paint()
        ..color = event!.color!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 40;
      // canvas.drawArc(rect, radStart, radEnd, false, fillBrush);

      path.arcTo(rect, radStart, radEnd, true);
      canvas.drawPath(path, fillBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Arc extends StatefulWidget {
  final Event event;
  const Arc(this.event, {Key? key}) : super(key: key);

  @override
  _ArcState createState() => _ArcState();
}

class _ArcState extends State<Arc> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {print('tappppp')},
      child: CustomPaint(
        painter: ArcPainter(widget.event),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () => {print('tappppp')},
  //     child: ClipPath(
  //       clipper: ArcClipper(widget.event),
  //     ),
  //   );
  // }
}

class ArcClipper extends CustomClipper<Path> {
  Event event;
  Path path = Path();

  ArcClipper(this.event);

  @override
  Path getClip(Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);

    const double rectSize = 141;
    final Rect rect =
        Rect.fromCenter(center: center, width: rectSize, height: rectSize);

    double radStart;
    double radEnd;
    final temp = event.from;
    final temp2 = event.to;
    radStart = temp.hour * pi / 12 + temp.minute * pi / 720 - pi / 2;
    radEnd = temp2.hour * pi / 12 + temp2.minute * pi / 720 - pi / 2 - radStart;
    if (temp2.hour == 0) {
      radEnd = 2 * pi - radStart - pi / 2;
    }
    path.arcTo(rect, radStart, radEnd, true);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
