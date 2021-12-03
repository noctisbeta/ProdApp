import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prod_app_3/screens/calendar_screen.dart';
// import 'package:prod_app_3/providers/date_provider.dart';
import 'package:prod_app_3/screens/calorie_adding_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:sqflite/sqflite.dart';
import '../database/calorie_event.dart';
import '../database/database.dart';

class CalorieScreen extends StatefulWidget {
  final DateTime dateTime;

  const CalorieScreen({Key? key, required this.dateTime}) : super(key: key);

  @override
  _CalorieScreenState createState() => _CalorieScreenState();
}

class _CalorieScreenState extends State<CalorieScreen> {
  Future<List<CalorieEvent>> getEvents() async {
    return DatabaseHelper.instance.getCalorieEvents(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CalendarScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.calendar_today,
            ),
          ),
        ],
        title: Text(
          "${DateFormat('EEEE').format(widget.dateTime)}'s Summary",
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return CalorieAddingScreen(
                  dateTime: widget.dateTime,
                );
              },
            ),
          ).then((value) {
            getEvents();
            setState(() {});
          });
        },
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Total'),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
          ),
          FutureBuilder<List<CalorieEvent>>(
            // future: eventsDB,
            // future: DatabaseHelper.instance.getCalorieEvents(widget.dateTime),
            future: getEvents(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<CalorieEvent>> snapshot,
            ) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(snapshot.data![index].food),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    children: const [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
