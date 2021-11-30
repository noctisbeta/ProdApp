import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  final DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;
  // DateTime? get currentDate => DateTime.now();
}
