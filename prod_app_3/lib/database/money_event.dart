import 'package:flutter/material.dart';

class MoneyEvent {
  final String location;
  final String forWhat;
  final Color color;
  final double amount;
  final TimeOfDay time;
  final DateTime dateTime;

  MoneyEvent({
    required this.location,
    required this.forWhat,
    required this.color,
    required this.amount,
    required this.time,
    required this.dateTime,
  });

  // factory MoneyEvent.fromMap(Map<String, dynamic> json) {

  // }

  @override
  String toString() {
    return location +
        forWhat +
        color.toString() +
        amount.toString() +
        time.toString() +
        dateTime.toString();
  }

  Map<String, dynamic> toMap() => {
        'location': location,
        'forWhat': forWhat,
        'color': color.toString(),
        'amount': amount.toString(),
        'time': time.toString(),
        'dateTime': dateTime.toString()
      };
}
