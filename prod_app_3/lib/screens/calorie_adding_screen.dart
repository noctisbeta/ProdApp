import 'package:flutter/material.dart';
import 'package:number_selection/number_selection.dart';
import 'package:prod_app_3/database/calorie_event.dart';
import 'package:prod_app_3/database/database.dart';

class CalorieAddingScreen extends StatefulWidget {
  final DateTime dateTime;

  const CalorieAddingScreen({Key? key, required this.dateTime})
      : super(key: key);

  @override
  _CalorieAddingScreenState createState() => _CalorieAddingScreenState();
}

class _CalorieAddingScreenState extends State<CalorieAddingScreen> {
  TextEditingController foodCtl = TextEditingController();
  TextEditingController calsCtl = TextEditingController();
  TextEditingController mealCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();
  int foodAmount = 1;
  TimeOfDay? time;

  GlobalKey numberKey = GlobalKey();

  String dropdownValue = 'Breakfast';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Ime'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: foodCtl,
                    decoration: const InputDecoration(
                      labelText: 'Food / Drink',
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: calsCtl,
                    decoration: const InputDecoration(
                      labelText: 'Calories',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 14,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Breakfast', 'Lunch', 'Dinner', 'Snack']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                //     child: TextFormField(
                //       controller: mealCtl,
                //       decoration: const InputDecoration(
                //         labelText: 'Meal',
                //       ),
                //     ),
                //   ),
                // ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextFormField(
                      onTap: () async {
                        final TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          // hourLabelText: 'a',
                          minuteLabelText: 'aaaaa',
                          // helpText: 'a',
                        );
                        if (newTime == null) {
                          return;
                        }
                        setState(() {
                          timeCtl.text = newTime
                              .toString()
                              .split('(')[1]
                              .replaceFirst(')', '');
                          time = newTime;
                        });
                      },
                      showCursor: false,
                      keyboardType: TextInputType.none,
                      controller: timeCtl,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              child: NumberSelection(
                key: numberKey,
                theme: NumberSelectionTheme(
                  draggableCircleColor: Theme.of(context).colorScheme.primary,
                  iconsColor: Colors.white,
                  numberColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  outOfConstraintsColor: Colors.deepOrange[200],
                ),
                initialValue: foodAmount,
                minValue: 1,
                direction: Axis.vertical,
                onChanged: (int value) {
                  setState(() {
                    foodAmount = value;
                  });
                },
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                if (foodCtl.text == '' ||
                    calsCtl.text == '' ||
                    mealCtl.text == '' ||
                    time == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      width: 110,
                      dismissDirection: DismissDirection.vertical,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      content: const Text('Missing info'),
                    ),
                  );
                  return;
                }

                final calorieEvent = CalorieEvent(
                  foodName: foodCtl.text,
                  foodAmount: foodAmount,
                  calories: int.parse(calsCtl.text),
                  dateTime: widget.dateTime,
                  meal: mealCtl.text,
                  time: time!,
                );

                DatabaseHelper.instance.addCalorieEvent(calorieEvent);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
