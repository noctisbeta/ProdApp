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

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        title: json['eventTitle'] as String,
        from: json['timeFrom'] as TimeOfDay,
        to: json['timeTo'] as TimeOfDay,
        color: json['eventColor'] as Color,
        dateTime: json['eventDateTime'] as DateTime,
      );

  @override
  String toString() {
    return title + from.toString() + to.toString();
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
