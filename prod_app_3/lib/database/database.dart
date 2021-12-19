import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'calorie_event.dart';
import 'money_event.dart';
import 'time_event.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'myDatabase.db');
    // print(documentsDirectory.path + 'ala');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS timeTable (
      eventID INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      timeFrom TEXT NOT NULL,
      timeTo TEXT NOT NULL,
      color TEXT NOT NULL,
      date TEXT NOT NULL
    );
    ''',
    );

    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS calorieTable (
      calorieEventID INTEGER PRIMARY KEY,
      foodName TEXT NOT NULL,
      foodAmount INTEGER NOT NULL,
      calories INTEGER NOT NULL,
      dateTime TEXT NOT NULL,
      date TEXT NOT NULL,
      time TEXT NOT NULL,
      meal TEXT NOT NULL
    );
    ''',
    );

    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS moneyTable (
      moneyEventID INTEGER PRIMARY KEY,
      location TEXT NOT NULL,
      forWhat TEXT NOT NULL,
      color TEXT NOT NULL,
      amount REAL NOT NULL,
      time TEXT NOT NULL,
      date TEXT NOT NULL
    );
    ''',
    );
  }

  Future<List<TimeEvent>> getTimeEvents(DateTime day) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> events = await db.query(
      'timeTable',
      where: 'date = ?',
      whereArgs: [day.toString().split(' ')[0]],
    );

    print(events[0]['color']);
    print(events[1]['color']);

    final List<TimeEvent> eventList = [];

    for (final pair in events) {
      eventList.add(TimeEvent.fromMap(pair));
    }
    return eventList;
  }

  Future<List<CalorieEvent>> getCalorieEvents(
    DateTime day, {
    String? mealType,
  }) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> events;
    if (mealType == null) {
      events = await db.query(
        'calorieTable',
        where: 'date = ?',
        whereArgs: [day.toString().split(' ')[0]],
      );
    } else {
      events = await db.query(
        'calorieTable',
        where: 'date = ? and meal = ?',
        whereArgs: [day.toString().split(' ')[0], mealType],
      );
    }

    final List<CalorieEvent> eventList = [];
    for (final pair in events) {
      eventList.add(CalorieEvent.fromMap(pair));
    }
    return eventList;
  }

  Future<List<MoneyEvent>> getMoneyEvents(DateTime day) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> events = await db.query(
      'moneyTable',
      where: 'date = ?',
      whereArgs: [day.toString().split(' ')[0]],
    );
    final List<MoneyEvent> eventList = [];
    for (final pair in events) {
      eventList.add(MoneyEvent.fromMap(pair));
    }
    return eventList;
  }

  Future<int> getTotalCalories(DateTime day) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> calories = await db.query(
      'calorieTable',
      where: 'date = ?',
      whereArgs: [day.toString().split(' ')[0]],
      columns: ['calories', 'foodAmount'],
    );

    int sum_ = 0;
    for (final mapItem in calories) {
      sum_ += (mapItem['calories'] as int) * (mapItem['foodAmount'] as int);
    }
    return sum_;
  }

  Future<int> addTimeEvent(TimeEvent event) async {
    final Database db = await instance.database;
    return db.insert(
      'timeTable',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> addCalorieEvent(CalorieEvent calorieEvent) async {
    final Database db = await instance.database;
    return db.insert(
      'calorieTable',
      calorieEvent.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> addMoneyEvent(MoneyEvent moneyEvent) async {
    final Database db = await instance.database;
    return db.insert(
      'moneyTable',
      moneyEvent.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
