import 'package:flutter/material.dart';

class CalorieEvent {
  final String foodName;
  final int foodAmount;
  final int calories;
  final DateTime dateTime;
  final String meal;
  final TimeOfDay time;

  CalorieEvent({
    required this.foodName,
    required this.foodAmount,
    required this.calories,
    required this.dateTime,
    required this.meal,
    required this.time,
  });
  DateTime get date => DateTime.parse(dateTime.toString().split(' ')[0]);
  // TimeOfDay get time => TimeOfDay.fromDateTime(dateTime);

  factory CalorieEvent.fromMap(Map<String, dynamic> json) {
    final DateTime dateTime = DateTime.parse(json['date'] as String);

    final TimeOfDay time = TimeOfDay(
      hour: int.parse((json['time'] as String).split(':')[0]),
      minute: int.parse((json['time'] as String).split(':')[1]),
    );

    final CalorieEvent newEvent = CalorieEvent(
      foodName: json['foodName'] as String,
      foodAmount: json['foodAmount'] as int,
      calories: json['calories'] as int,
      dateTime: dateTime,
      meal: json['meal'] as String,
      time: time,
    );
    return newEvent;
  }

  Map<String, dynamic> toMap() => {
        'foodName': foodName,
        'foodAmount': foodAmount,
        'calories': calories,
        'dateTime': dateTime.toString(),
        'date': dateTime.toString().split(' ')[0],
        'time': time.toString().split('(')[1].replaceFirst(')', ''),
        'meal': meal,
      };
}
