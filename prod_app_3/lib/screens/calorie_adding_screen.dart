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
  int foodAmount = 1;

  GlobalKey numberKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ime'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: foodCtl,
                      decoration: const InputDecoration(
                        labelText: 'Hrana',
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: calsCtl,
                      decoration: const InputDecoration(
                        labelText: 'Kalorije',
                      ),
                    ),
                  ),
                ],
              ),
              // const Spacer(),
              const SizedBox(
                height: 60,
              ),
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
              const SizedBox(
                height: 60,
              ),
              TextButton(
                onPressed: () {
                  if (foodCtl.text == '' || calsCtl.text == '') {
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
                  setState(() {
                    final calorieEvent = CalorieEvent(
                      food: foodCtl.text,
                      foodAmount: foodAmount,
                      calories: int.parse(calsCtl.text),
                      dateTime: widget.dateTime,
                    );
                    DatabaseHelper.instance.addCalorieEvent(calorieEvent);
                    Navigator.pop(context);
                  });
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
