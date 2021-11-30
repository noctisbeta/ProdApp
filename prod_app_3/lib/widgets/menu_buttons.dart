import 'package:flutter/material.dart';
import 'package:prod_app_3/providers/date_provider.dart';
import 'package:prod_app_3/screens/calendar_screen.dart';
import 'package:provider/provider.dart';

import '../providers/date_provider.dart';
// import 'package:prod_app_3/screens/day_summary_screen.dart';
import '../screens/calorie_screen.dart';
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
                return const MoneySummaryScreen();
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
                return Container();
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
