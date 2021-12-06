import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'calorie_event.dart';
import 'event.dart';
import 'money_event.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'events.db');
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
      CREATE TABLE eventsTable (
      eventID INTEGER PRIMARY KEY,
      eventTitle TEXT NOT NULL,
      timeFrom TEXT NOT NULL,
      timeTo TEXT NOT NULL,
      eventColor TEXT NOT NULL,
      eventDate TEXT NOT NULL
    );
    ''',
    );

    await db.execute(
      '''
      CREATE TABLE calorieTable (
      calorieEventID INTEGER PRIMARY KEY,
      food TEXT NOT NULL,
      foodAmount INTEGER NOT NULL,
      calories INTEGER NOT NULL,
      dateTime TEXT NOT NULL,
      date TEXT NOT NULL,
      time TEXT NOT NULL
    );
    ''',
    );

    await db.execute(
      '''
      CREATE TABLE calorieTable (
      moneyEventID INTEGER PRIMARY KEY,
      location TEXT NOT NULL,
      forWhat TEXT NOT NULL,
      color TEXT NOT NULL,
      time TEXT NOT NULL,
      dateTime TEXT NOT NULL
    );
    ''',
    );
  }

  Future<List<Event>> getEvents() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> events = await db.query('events');
    // final List<Event> eventList =
    //     events.isNotEmpty ? events.map((e) => Event.fromMap(e)).toList() : [];
    final List<Event> eventList = [];
    for (final pair in events) {
      eventList.add(Event.fromMap(pair));
    }
    return eventList;
  }

  Future<List<Event>> getTodaysEvents(DateTime day) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> events = await db.query(
      'eventsTable',
      where: 'eventDate = ?',
      whereArgs: [day.toString().split(' ')[0]],
    );
    final List<Event> eventList = [];
    for (final pair in events) {
      eventList.add(Event.fromMap(pair));
    }
    return eventList;
  }

  Future<List<CalorieEvent>> getCalorieEvents(DateTime day) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> events = await db.query(
      'calorieTable',
      where: 'date = ?',
      whereArgs: [day.toString().split(' ')[0]],
    );
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
    final List<Map<String, dynamic>> amounts = await db.query(
      'calorieTable',
      where: 'date = ?',
      whereArgs: [day.toString().split(' ')[0]],
      columns: ['foodAmount'],
    );
    int sum_ = 0;
    for (final mapItem in calories) {
      sum_ += (mapItem['calories'] as int) * (mapItem['foodAmount'] as int);
    }
    return sum_;
  }

  Future<int> add(Event event) async {
    final Database db = await instance.database;
    return db.insert(
      'eventsTable',
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
}
