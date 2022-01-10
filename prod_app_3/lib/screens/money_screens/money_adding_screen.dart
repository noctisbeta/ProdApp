import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../../database/money_event.dart';

class MoneyAddingScreen extends StatefulWidget {
  final DateTime dateTime;
  const MoneyAddingScreen({
    required this.dateTime,
    Key? key,
  }) : super(key: key);

  @override
  _MoneyAddingScreenState createState() => _MoneyAddingScreenState();
}

class _MoneyAddingScreenState extends State<MoneyAddingScreen> {
  TextEditingController timeCtl = TextEditingController();
  TextEditingController locCtl = TextEditingController();
  TextEditingController forCtl = TextEditingController();
  TextEditingController amountCtl = TextEditingController();
  TextEditingController helperCtl = TextEditingController(
    text: '0€',
  );

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
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: amountCtl,
                    onChanged: (value) {
                      setState(() {
                        helperCtl.text = '$value€';
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      // hintText: amountCtl.text,
                      // helperText: helperCtl.text,
                    ),
                  ),
                ),
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
            TextButton(
              onPressed: () {
                if (locCtl.text == '' ||
                    forCtl.text == '' ||
                    amountCtl.text == '' ||
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

                final moneyEvent = MoneyEvent(
                  location: locCtl.text,
                  forWhat: forCtl.text,
                  color: Colors.pink,
                  amount: double.parse(amountCtl.text),
                  time: time!,
                  dateTime: widget.dateTime,
                );

                DatabaseHelper.instance.addMoneyEvent(moneyEvent);
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
          ],
        ),
      ),
    );
  }
}
