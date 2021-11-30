import 'package:flutter/material.dart';

class CalorieEvent {
  final String food;
  final int foodAmount;
  final int calories;
  final DateTime dateTime;
  // late DateTime _date;
  // late TimeOfDay _time;

  CalorieEvent({
    required this.food,
    required this.foodAmount,
    required this.calories,
    required this.dateTime,
  });
  DateTime get date => DateTime.parse(dateTime.toString().split(' ')[0]);
  TimeOfDay get time => TimeOfDay.fromDateTime(dateTime);

  factory CalorieEvent.fromMap(Map<String, dynamic> json) {
    final DateTime dateTime = DateTime.parse(json['date'] as String);

    final CalorieEvent newEvent = CalorieEvent(
      food: json['food'] as String,
      foodAmount: json['foodAmount'] as int,
      calories: json['calories'] as int,
      dateTime: dateTime,
    );
    return newEvent;
  }

  Map<String, dynamic> toMap() => {
        'food': food,
        'foodAmount': foodAmount,
        'calories': calories,
        'dateTime': dateTime.toString(),
        'date': dateTime.toString().split(' ')[0],
        'time': dateTime.toString().split(' ')[1],
      };
}
