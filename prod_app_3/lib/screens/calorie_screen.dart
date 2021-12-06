import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // import 'package:prod_app_3/providers/date_provider.dart';
import 'package:prod_app_3/screens/calorie_adding_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:sqflite/sqflite.dart';
import '../database/calorie_event.dart';
import '../database/database.dart';
import '../widgets/menu_buttons.dart';

class CalorieScreen extends StatefulWidget {
  final DateTime dateTime;

  const CalorieScreen({Key? key, required this.dateTime}) : super(key: key);

  @override
  _CalorieScreenState createState() => _CalorieScreenState();
}

class _CalorieScreenState extends State<CalorieScreen> {
  String titleText = '';
  Future<List<CalorieEvent>> getEvents() async {
    return DatabaseHelper.instance.getCalorieEvents(widget.dateTime);
  }

  Future<int> getTotal() async {
    return DatabaseHelper.instance.getTotalCalories(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: const [
          CalendarAppBar(
            screenName: 'calories',
          ),
        ],
        title: Text(
          "${DateFormat('EEEE').format(widget.dateTime)}'s Calories",
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
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    FutureBuilder<int>(
                      future: getTotal(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            '${snapshot.data!} kcal',
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text('database empty');
                        } else {
                          return Center(
                            child: Column(
                              children: const [
                                CircularProgressIndicator(),
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
                    const Spacer()
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
          ),
          FutureBuilder<List<CalorieEvent>>(
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
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Text(snapshot.data![index].food),
                            Text(' (${snapshot.data![index].foodAmount})'),
                            const Spacer(),
                            Text(
                              '${snapshot.data![index].calories * snapshot.data![index].foodAmount}kcal',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('database empty');
              } else {
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
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
