import 'package:flutter/material.dart';

class Event {
  final String title;
  final TimeOfDay from;
  final TimeOfDay to;
  final Color? color;
  final DateTime dateTime;

  const Event({
    required this.title,
    required this.from,
    required this.to,
    required this.color,
    required this.dateTime,
  });

  @override
  String toString() {
    return title + from.toString() + to.toString();
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'from': from.toString(),
        'to': to.toString(),
        'color': color.toString(),
        'dateTime': dateTime.toString(),
      };
}
