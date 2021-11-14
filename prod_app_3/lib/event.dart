import 'package:flutter/material.dart';

class Event {
  final String title;
  final TimeOfDay from;
  final TimeOfDay to;
  final Color color;
  final DateTime dateTime;

  Event({
    required this.title,
    required this.from,
    required this.to,
    required this.color,
    required this.dateTime,
  });

  factory Event.fromMap(Map<String, dynamic> json) {
    final String fromStr = json['timeFrom'] as String;
    final String fromStrTime = fromStr.substring(10, 15);
    final List<String> l = fromStrTime.split(':');
    final String s21 = l[0];
    final String s22 = l[1];

    final TimeOfDay timeFrom = TimeOfDay(
      hour: int.parse(s21),
      minute: int.parse(s22),
    );

    final String toStr = json['timeTo'] as String;
    final String toStrTime = toStr.substring(10, 15);
    final List<String> k = toStrTime.split(':');
    final String t21 = k[0];
    final String t22 = k[1];

    final TimeOfDay timeTo = TimeOfDay(
      hour: int.parse(t21),
      minute: int.parse(t22),
    );

    final DateTime dateTime = DateTime.parse(json['eventDateTime'] as String);
    final String colorStr = json['eventColor'] as String;
    final List<String> c = colorStr.split(':');
    final String color =
        c[1].substring(c[1].indexOf('(') + 1, c[1].lastIndexOf(')') - 1);

    final Event newEvent = Event(
      title: json['eventTitle'] as String,
      from: timeFrom,
      to: timeTo,
      color: Color(int.parse(color)),
      dateTime: dateTime,
    );

    return newEvent;
  }

  @override
  String toString() {
    return title +
        from.toString() +
        to.toString() +
        color.toString() +
        dateTime.toString();
  }

  Map<String, dynamic> toMap() => {
        // 'eventID': 0,
        'eventTitle': title,
        'timeFrom': from.toString(),
        'timeTo': to.toString(),
        'eventColor': color.toString(),
        'eventDateTime': dateTime.toString(),
      };
}
