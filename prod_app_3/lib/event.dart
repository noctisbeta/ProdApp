import 'package:flutter/material.dart';

class Event {
  final String title;
  final TimeOfDay from;
  final TimeOfDay to;
  final Color? color;

  const Event({
    required this.title,
    required this.from,
    required this.to,
    this.color
  });

  @override
  String toString() {
    return title + from.toString() + to.toString();
  }
}