import 'package:flutter/material.dart';

class MoneyAddingScreen extends StatefulWidget {
  const MoneyAddingScreen({Key? key}) : super(key: key);

  @override
  _MoneyAddingScreenState createState() => _MoneyAddingScreenState();
}

class _MoneyAddingScreenState extends State<MoneyAddingScreen> {
  TextEditingController timeCtl = TextEditingController();
  TextEditingController locCtl = TextEditingController();
  TextEditingController forCtl = TextEditingController();

  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: locCtl,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: forCtl,
                    decoration: const InputDecoration(
                      labelText: 'For What',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    onTap: () async {
                      final TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
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
              ],
            ),
            const Spacer(),

            const Spacer(),
            // TextButton(
            //   onPressed: () {
            //     if (foodCtl.text == '' ||
            //         calsCtl.text == '' ||
            //         meal == '' ||
            //         time == null) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           behavior: SnackBarBehavior.floating,
            //           width: 110,
            //           dismissDirection: DismissDirection.vertical,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10.0),
            //           ),
            //           content: const Text('Missing info'),
            //         ),
            //       );
            //       return;
            //     }

            //     final calorieEvent = CalorieEvent(
            //       foodName: foodCtl.text,
            //       foodAmount: foodAmount,
            //       calories: int.parse(calsCtl.text),
            //       dateTime: widget.dateTime,
            //       meal: meal,
            //       time: time!,
            //     );

            //     DatabaseHelper.instance.addCalorieEvent(calorieEvent);
            //     Navigator.pop(context);
            //   },
            //   style: ButtonStyle(
            //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15.0),
            //         side: BorderSide(
            //           color: Theme.of(context).colorScheme.primary,
            //         ),
            //       ),
            //     ),
            //   ),
            //   child: Container(
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: Theme.of(context).colorScheme.primary,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: const Text(
            //       'Confirm',
            //       style: TextStyle(
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
