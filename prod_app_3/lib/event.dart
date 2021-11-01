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
        title: json['title'] as String,
        from: json['from'] as TimeOfDay,
        to: json['to'] as TimeOfDay,
        color: json['color'] as Color,
        dateTime: json['dateTime'] as DateTime,
      );

  @override
  String toString() {
    return title + from.toString() + to.toString();
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'from': from.toString(),
        'to': to.toString(),
        'color': color.toString(),
        'dateTime': dateTime.toString(),
      };
}
