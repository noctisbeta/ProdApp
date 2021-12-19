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
        'time': time.toString().split('(')[1].replaceFirst(')', ''),
        'date': dateTime.toString().split(' ')[0]
      };

  factory MoneyEvent.fromMap(Map<String, dynamic> json) {
    final DateTime dateTime = DateTime.parse(json['date'] as String);
    final String colorStr = json['color'] as String;
    final List<String> c = colorStr.split(':');
    final String color =
        c[1].substring(c[1].indexOf('(') + 1, c[1].lastIndexOf(')') - 1);

    final MoneyEvent newEvent = MoneyEvent(
      location: json['location'] as String,
      forWhat: json['forWhat'] as String,
      color: Color(int.parse(color)),
      amount: json['amount'] as double,
      time: TimeOfDay.now(),
      dateTime: dateTime,
    );
    return newEvent;
  }
}
