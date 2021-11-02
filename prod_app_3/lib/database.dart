import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'event.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'events.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // await db.execute(
    // 'CREATE TABLE events ( eventID INTEGER PRIMARY KEY, eventTitle TEXT, timeFrom TEXT, timeTo TEXT, eventColor TEXT, eventDateTime TEXT );');
    await db.execute(
      '''
      CREATE TABLE events (
      eventID INTEGER PRIMARY KEY,
      eventTitle TEXT NOT NULL,
      timeFrom TEXT NOT NULL,
      timeTo TEXT NOT NULL,
      eventColor TEXT NOT NULL,
      eventDateTime TEXT NOT NULL
    );
    ''',
    );
  }

  Future<List<Event>> getEvents() async {
    final Database db = await instance.database;
    final events = await db.query('events');
    final List<Event> eventList =
        events.isNotEmpty ? events.map((e) => Event.fromMap(e)).toList() : [];
    print('eventList:');
    print(eventList);
    return eventList;
  }

  Future<int> add(Event event) async {
    final Database db = await instance.database;
    return db.insert(
      'events',
      event.toMap(),
    );
  }
}
