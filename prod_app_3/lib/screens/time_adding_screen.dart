import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:prod_app_3/database/database.dart';

import '../database/database.dart';
import '../database/time_event.dart';

class TimeAddingPage extends StatefulWidget {
  final DateTime selectedDate;
  final List<TimeEvent> events;

  const TimeAddingPage({
    Key? key,
    required this.selectedDate,
    required this.events,
  }) : super(key: key);

  @override
  _TimeAddingPageState createState() => _TimeAddingPageState();
}

class _TimeAddingPageState extends State<TimeAddingPage> {
  TimeOfDay? time;
  TextEditingController timeCtlFrom = TextEditingController();
  TextEditingController timeCtlTo = TextEditingController();
  TextEditingController nameCtl = TextEditingController();

  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  final formKey = GlobalKey<FormState>();
  final colorKey = GlobalKey<FormState>();

  bool isOkay = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Enter Details'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: nameCtl,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: (String? value) {
                    return isOkayTitle(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    // hintText: 'Name',
                    border: OutlineInputBorder(),
                    helperText: 'Enter name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: timeCtlFrom,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return isOkayFrom(value);
                        },
                        decoration: const InputDecoration(
                          // hintText: 'From',
                          labelText: 'From',
                          border: OutlineInputBorder(),
                          helperText: 'Enter start time',
                        ),
                        onTap: () => pickTime('from'),
                        readOnly: true,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: timeCtlTo,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return isOkayTo(value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'To',
                          border: OutlineInputBorder(),
                          helperText: 'Enter end time',
                        ),
                        onTap: () => pickTime('to'),
                        readOnly: true,
                        showCursor: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    myColorPicker(),
                    if (isOkayColor())
                      Text(
                        'Event color',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    else
                      Text(
                        'Color already used',
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: TextButton(
                    onPressed: confirmSubmission,
                    child: const Text(
                      'CONFIRM',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> pickTime(String choice) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );

    if (newTime == null) return;

    // time = newTime;
    switch (choice) {
      case 'from':
        timeCtlFrom.text = '${newTime.hour}:${newTime.minute}';
        fromTime = newTime;
        break;

      case 'to':
        timeCtlTo.text = '${newTime.hour}:${newTime.minute}';
        toTime = newTime;
        break;

      default:
        return;
    }
  }

  Color currentColor = Colors.black;
  void changeColor(Color color) => setState(() => currentColor = color);

  Widget myColorPicker() => GestureDetector(
        key: colorKey,
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Pick Color'),
            contentPadding: const EdgeInsets.all(10),
            content: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: changeColor,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('SELECT'),
              )
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: currentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 100,
          width: 100,
        ),
      );

  Future<void> confirmSubmission() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final TimeEvent newEvent = TimeEvent(
      title: nameCtl.text,
      from: fromTime!,
      to: toTime!,
      color: currentColor,
      dateTime: widget.selectedDate,
    );

    await DatabaseHelper.instance.addTimeEvent(newEvent);

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  String? isOkayTitle(String? title) {
    if (title == null || title == "") {
      isOkay = false;
      return "Required";
    }

    for (int i = 0; i < widget.events.length; i++) {
      if (widget.events[i].title == title) {
        if (currentColor == widget.events[i].color) {
          isOkay = true;
          return null;
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            changeColor(widget.events[i].color);

            const snackBar = SnackBar(
              content: Text(
                'Changed color to match name',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 5),
              elevation: 100,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
        isOkay = true;
        return null;
      }
    }
    isOkay = true;
    return null;
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  String? isOkayFrom(String? from) {
    if (from == null || from == "") {
      isOkay = false;
      return "Required";
    }
    for (int i = 0; i < widget.events.length; i++) {
      final TimeOfDay tempTime = TimeOfDay(
        hour: int.parse(from.split(":")[0]),
        minute: int.parse(from.split(":")[1]),
      );

      final compareTime = widget.events[i];
      if (toDouble(compareTime.from) <= toDouble(tempTime) &&
          toDouble(compareTime.to) > toDouble(tempTime)) {
        isOkay = false;
        return "Conflicting times";
      }
    }
    isOkay = true;
    return null;
  }

  String? isOkayTo(String? to) {
    if (to == null || to == "") {
      isOkay = false;
      return "Required";
    }
    for (int i = 0; i < widget.events.length; i++) {
      final TimeOfDay tempTime = TimeOfDay(
        hour: int.parse(to.split(":")[0]),
        minute: int.parse(to.split(":")[1]),
      );

      final compareTime = widget.events[i];
      if (toDouble(compareTime.from) < toDouble(tempTime) &&
          toDouble(compareTime.to) > toDouble(tempTime)) {
        isOkay = false;
        return "Conflicting times";
      }
    }
    isOkay = true;
    return null;
  }

  bool isOkayColor() {
    if (widget.events.isEmpty) {
      isOkay = true;
      return true;
    }
    for (int i = 0; i < widget.events.length; i++) {
      if (widget.events[i].color == currentColor) {
        if (nameCtl.text == widget.events[i].title) {
          return true;
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            setState(() {
              nameCtl.text = widget.events[i].title;
            });
            const snackBar = SnackBar(
              content: Text(
                'Changed name to match color',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 5),
              elevation: 100,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
        return false;
      }
    }
    return true;
  }
}
