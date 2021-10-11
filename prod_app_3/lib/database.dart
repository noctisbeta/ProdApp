import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'event.dart';

class DatabaseModel extends ChangeNotifier {
  late final Database database;

  Future initDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'prod_app_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE days(date TEXT PRIMARY KEY, events TEXT)',
        );
      },
      version: 1,
    );

    this.database = await database;
  }

  Future<void> insertDayData(DayDataDB dayData) async {
    final db = database;
    await db.insert(
      'days',
      dayData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<DayDataDB>> dogs() async {
    // Get a reference to the database.
    final db = database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('days');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return DayDataDB(
        id: maps[i]['id'] as int,
        date: maps[i]['date'] as String,
        events: maps[i]['events'] as String,
      );
    });
  }
}

class DayDataDB {
  int id;
  String date;
  String events;

  DayDataDB({
    required this.id,
    required this.date,
    required this.events,
  });

  DayDataDB.fromEvent(Event event)
      : id = 1,
        date = '2',
        events = event.toString();

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'events': events,
    };
  }

  @override
  String toString() {
    return 'DayData{date: $date, events: $events}';
  }
}
