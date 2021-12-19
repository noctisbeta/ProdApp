import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prod_app_3/screens/calorie_screen.dart';
import 'package:prod_app_3/screens/day_summary_screen.dart';
import 'package:prod_app_3/screens/money_summary.dart';

import '../widgets/menu_buttons.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 1;
  String _titleDate = DateFormat('EEEE').format(DateTime.now());
  String _titleType = 'Time';
  DateTime _currentDate = DateTime.now();
  final List<Widget> _screens = [
    MoneySummaryScreen(
      dateTime: DateTime.now(),
    ),
    DaySummaryScreen(
      dateTime: DateTime.now(),
    ),
    CalorieScreen(
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        changeIndex: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                _titleType = 'Money';
                break;
              case 1:
                _titleType = 'Time';
                break;
              case 2:
                _titleType = 'Calories';
                break;
            }
          });
        },
      ),
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("$_titleDate's $_titleType"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            final newDate = await showDatePicker(
              context: context,
              initialDate: _currentDate,
              firstDate: DateTime.parse('2021-12-01'),
              lastDate: DateTime.now().add(
                const Duration(days: 7),
              ),
            );
            if (newDate == null) {
              return;
            }
            setState(() {
              _titleDate = DateFormat('EEEE').format(newDate);
              _currentDate = newDate;
              final Widget newScreen;
              switch (_currentIndex) {
                case 0:
                  newScreen = MoneySummaryScreen(dateTime: newDate);
                  break;
                case 1:
                  newScreen = DaySummaryScreen(dateTime: newDate);
                  break;
                case 2:
                  newScreen = CalorieScreen(dateTime: newDate);
                  break;
                default:
                  newScreen = const SizedBox.shrink();
              }
              _screens[_currentIndex] = newScreen;
            });
          },
          icon: const Icon(
            Icons.calendar_today,
          ),
        ),
      ],
    );
  }
}
