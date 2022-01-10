import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prod_app_3/screens/calorie_screen.dart';

import 'money_screens/money_summary_screen.dart';
import 'time_screens/time_summary_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _titleDate = DateFormat('EEEE').format(DateTime.now());
  String _titleType = 'Time';
  DateTime _currentDate = DateTime.now();

  void _updateTitle({String? titleDate, String? titleType}) {
    setState(() {
      if (titleType != null) {
        _titleType = titleType;
      }
      if (titleDate != null) {
        _titleDate = titleDate;
      }
    });
  }

  int _selectedNavBarIndex = 1;

  late final List<Widget> _screens = [
    MoneySummaryScreen(
      dateTime: DateTime.now(),
      changeTitleCallback: _updateTitle,
    ),
    TimeSummaryScreen(
      dateTime: DateTime.now(),
    ),
    CalorieScreen(
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildNavBar(),
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _selectedNavBarIndex,
        children: _screens,
      ),
    );
  }

  BottomNavigationBar _buildNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedNavBarIndex,
      onTap: (index) {
        setState(() {
          _selectedNavBarIndex = index;

          switch (_selectedNavBarIndex) {
            case 0:
              _titleType = "'s Money";
              break;
            case 1:
              _titleType = "'s Time";
              break;
            case 2:
              _titleType = "'s Calories";
              break;
          }
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Money',
          icon: Icon(
            Icons.money,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Time',
          icon: Icon(
            Icons.access_time,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Calories',
          icon: Icon(
            Icons.food_bank,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("$_titleDate$_titleType"),
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
              switch (_selectedNavBarIndex) {
                case 0:
                  newScreen = MoneySummaryScreen(
                    dateTime: newDate,
                    changeTitleCallback: _updateTitle,
                  );
                  break;
                case 1:
                  newScreen = TimeSummaryScreen(dateTime: newDate);
                  break;
                case 2:
                  newScreen = CalorieScreen(dateTime: newDate);
                  break;
                default:
                  newScreen = const SizedBox.shrink();
              }
              _screens[_selectedNavBarIndex] = newScreen;
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
