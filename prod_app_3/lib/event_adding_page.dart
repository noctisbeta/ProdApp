// import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:time_range_picker/time_range_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'event.dart';

class EventAddingPage extends StatefulWidget {
  final List<Event> events;

  const EventAddingPage({Key? key, required this.events}) : super(key: key);

  @override
  _EventAddingPageState createState() => _EventAddingPageState();
}

class _EventAddingPageState extends State<EventAddingPage> {
  TimeOfDay? time;
  TextEditingController timeCtlFrom = TextEditingController();
  TextEditingController timeCtlTo = TextEditingController();
  TextEditingController nameCtl = TextEditingController();

  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Enter Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: nameCtl,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                  helperText: 'Enter name',
                ),
              )),
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: timeCtlFrom,
                    decoration: const InputDecoration(
                      hintText: 'From',
                      border: OutlineInputBorder(),
                      helperText: 'Enter start time',
                    ),
                    onTap: () => pickTime('from'),
                    readOnly: true,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: timeCtlTo,
                    decoration: const InputDecoration(
                      hintText: 'To',
                      border: OutlineInputBorder(),
                      helperText: 'Enter end time',
                    ),
                    onTap: () => pickTime('to'),
                    readOnly: true,
                    showCursor: false,
                  ),
                ),
              ),
            ],
          ),
          Column(children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: myColorPicker()),
            const Text(
              'Event color',
              style: TextStyle(color: Colors.grey),
            )
          ]),
          const Expanded(child: SizedBox()),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
              ),
              onPressed: confirmSubmission,
              child: const Text(
                'CONFIRM',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       TimeRange result = await showTimeRangePicker(
          //           context: context,
          //           paintingStyle: PaintingStyle.stroke,
          //           strokeColor: Colors.indigoAccent,
          //           handlerColor: Colors.indigo,
          //           selectedColor: Colors.indigoAccent,
          //           ticks: 24,
          //           labels: [
          //             ClockLabel(angle: -pi / 2, text: '12'),
          //             ClockLabel(angle: 0, text: '18'),
          //             ClockLabel(angle: pi / 2, text: '24'),
          //             ClockLabel(angle: pi, text: '6'),
          //             ClockLabel(angle: pi / 4, text: '21'),
          //             ClockLabel(angle: -pi / 4, text: '15'),
          //             ClockLabel(angle: 3 * pi / 4, text: '3'),
          //             ClockLabel(angle: -3 * pi / 4, text: '9'),
          //           ],
          //           rotateLabels: false,
          //           backgroundWidget: Container(
          //             width: 195.0,
          //             height: 195.0,
          //             decoration: new BoxDecoration(
          //               color: Color.fromARGB(50, 10, 10, 10),
          //               shape: BoxShape.circle,
          //             ),
          //           ));
          //     },
          //     child: Text("Pure"),
          //   ),
          // )
        ],
      ));

  Future pickTime(String choice) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );

    if (newTime == null) return;

    time = newTime;
    switch (choice) {
      case 'from':
        timeCtlFrom.text = '${time!.hour}:${time!.minute}';
        fromTime = newTime;
        break;

      case 'to':
        timeCtlTo.text = '${time!.hour}:${time!.minute}';
        toTime = newTime;
        break;

      default:
        return;
    }
  }

  Color currentColor = Colors.black;
  void changeColor(Color color) => setState(() => currentColor = color);

  Widget myColorPicker() => GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Pick Color'),
                  contentPadding: const EdgeInsets.all(10),
                  content: Column(
                    children: [
                      BlockPicker(
                          pickerColor: currentColor,
                          onColorChanged: changeColor),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('SELECT'),
                    )
                  ],
                )),
        child: Container(
          decoration: BoxDecoration(
              color: currentColor, borderRadius: BorderRadius.circular(10)),
          height: 100,
          width: 100,
        ),
      );

  void confirmSubmission() {
    widget.events.add(Event(
        title: nameCtl.text,
        from: fromTime!,
        to: toTime!,
        color: currentColor));
    Navigator.pop(context, widget.events);
  }
}
