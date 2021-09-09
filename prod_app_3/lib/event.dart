import 'package:flutter/material.dart';

class Event {
  final String title;
  final TimeOfDay from;
  final TimeOfDay to;
  final Color? backgroundColor;

  const Event({
    required this.title,
    required this.from,
    required this.to,
    this.backgroundColor
  });

  String toString() {
    return title + from.toString() + to.toString();
  }
}