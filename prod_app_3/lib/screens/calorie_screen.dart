import 'package:flutter/material.dart';
// import 'package:prod_app_3/providers/date_provider.dart';
import 'package:prod_app_3/screens/calorie_adding_screen.dart';
import '../database/calorie_event.dart';
import '../database/database.dart';

class CalorieScreen extends StatefulWidget {
  final DateTime dateTime;

  const CalorieScreen({Key? key, required this.dateTime}) : super(key: key);

  @override
  _CalorieScreenState createState() => _CalorieScreenState();
}

class _CalorieScreenState extends State<CalorieScreen> {
  List<bool> mealsOpen = [false, false, false, false];

  Future<List<CalorieEvent>> getEvents({String? mealType}) async {
    return DatabaseHelper.instance
        .getCalorieEvents(widget.dateTime, mealType: mealType);
  }

  Future<int> getTotal() async {
    return DatabaseHelper.instance.getTotalCalories(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   actions: [
      //     CalendarAppBar(
      //       changeDateTime: (x){},
      //       screenName: 'calories',
      //       currentDate: widget.dateTime,
      //     ),
      //   ],
      //   title: Text(
      //     "${DateFormat('EEEE').format(widget.dateTime)}'s Calories",
      //   ),
      //   centerTitle: true,
      // ),
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
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20),
              // padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
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
                ],
              ),
            ),
          ),
          Divider(
            endIndent: 10,
            indent: 10,
            color: Theme.of(context).colorScheme.primary,
          ),
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                Row(
                  children: [
                    const MealLabel(
                      title: 'Breakfast',
                    ),
                    FutureBuilder<List<CalorieEvent>>(
                      future: getEvents(mealType: 'Breakfast'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return showMealsButton(context, index: 0);
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
                futureMealBuilder('Breakfast'),
                Row(
                  children: [
                    const MealLabel(
                      title: 'Lunch',
                    ),
                    FutureBuilder<List<CalorieEvent>>(
                      future: getEvents(mealType: 'Lunch'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return showMealsButton(context, index: 1);
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
                futureMealBuilder('Lunch'),
                Row(
                  children: [
                    const MealLabel(
                      title: 'Dinner',
                    ),
                    FutureBuilder<List<CalorieEvent>>(
                      future: getEvents(mealType: 'Dinner'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return showMealsButton(context, index: 2);
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
                futureMealBuilder('Dinner'),
                Row(
                  children: [
                    const MealLabel(
                      title: 'Snacks',
                    ),
                    FutureBuilder<List<CalorieEvent>>(
                      future: getEvents(mealType: 'Snack'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return showMealsButton(context, index: 3);
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
                futureMealBuilder('Snack'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Visibility showMealsButton(BuildContext context, {required int index}) {
    return Visibility(
      visible: !mealsOpen[index],
      child: GestureDetector(
        onTap: () {
          setState(() {
            mealsOpen[index] = !mealsOpen[index];
          });
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Visibility futureMealBuilder(String mealType) {
    int index = 0;
    switch (mealType) {
      case 'Breakfast':
        index = 0;
        break;
      case 'Lunch':
        index = 1;
        break;
      case 'Dinner':
        index = 2;
        break;
      case 'Snack':
        index = 3;
        break;
    }
    return Visibility(
      visible: mealsOpen[index],
      child: FutureBuilder<List<CalorieEvent>>(
        future: getEvents(mealType: mealType),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: 40,
              child: Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          mealsOpen[index] = !mealsOpen[index];
                        });
                      },
                      child: Icon(
                        Icons.remove,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 18,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            FoodEntry(
                              event: snapshot.data![index],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class FoodEntry extends StatelessWidget {
  final CalorieEvent event;
  const FoodEntry({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(event.foodName),
          Text(' (${event.foodAmount})'),
          const SizedBox(
            width: 30,
          ),
          // const Spacer(),
          Text(
            '${event.calories * event.foodAmount}kcal',
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class MealLabel extends StatelessWidget {
  final String title;
  const MealLabel({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
