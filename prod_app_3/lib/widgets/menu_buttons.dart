import 'package:flutter/material.dart';
import 'package:prod_app_3/providers/date_provider.dart';
import 'package:prod_app_3/screens/calendar_screen.dart';
import 'package:provider/provider.dart';

import '../providers/date_provider.dart';
// import 'package:prod_app_3/screens/day_summary_screen.dart';
import '../screens/calorie_screen.dart';
import '../screens/day_summary_screen.dart';
// import '../screens/day_summary_screen.dart';
import '../screens/money_summary.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const CalendarScreen();
              },
            ),
          );
        },
        splashColor: Colors.red,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Text('Calendar'),
        ),
      ),
    );
  }
}

class MoneyButton extends StatelessWidget {
  const MoneyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return MoneySummaryScreen(
                  dateTime: DateTime.now(),
                );
              },
            ),
          );
        },
        splashColor: Colors.red,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Text('Money Summary'),
        ),
      ),
    );
  }
}

class TimeButton extends StatelessWidget {
  const TimeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                // return const DaySummaryScreen();
                return DaySummaryScreen(date: DateTime.now());
              },
            ),
          );
        },
        splashColor: Colors.red,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Text('Time Summary'),
        ),
      ),
    );
  }
}

class CalorieButton extends StatelessWidget {
  const CalorieButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Consumer<DateProvider>(
                  builder: (context, datePro, child) {
                    return CalorieScreen(
                      dateTime: DateTime.now(),
                    );
                  },
                );
              },
            ),
          );
        },
        splashColor: Colors.red,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Text('Calorie Summary'),
        ),
      ),
    );
  }
}

class CalendarAppBar extends StatefulWidget {
  final String screenName;
  const CalendarAppBar({
    required this.screenName,
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarAppBar> createState() => _CalendarAppBarState();
}

class _CalendarAppBarState extends State<CalendarAppBar> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final newDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.parse('2021-12-01'),
          lastDate: DateTime.now().add(
            const Duration(days: 7),
          ),
        );
        if (newDate == null) {
          return;
        }
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              switch (widget.screenName) {
                case 'calories':
                  return CalorieScreen(
                    dateTime: newDate,
                  );
                case 'time':
                  return DaySummaryScreen(
                    date: newDate,
                  );
                case 'money':
                  return MoneySummaryScreen(
                    dateTime: newDate,
                  );
                default:
                  return Container();
              }
            },
          ),
        );
      },
      icon: const Icon(
        Icons.calendar_today,
      ),
    );
  }
}
