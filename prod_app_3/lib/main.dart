import 'package:flutter/material.dart';
import 'package:prod_app_3/screens/calendar_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
      title: 'Productivity app',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.pink[300],
              secondary: Colors.indigoAccent,
              brightness: Brightness.light,
            ),
        focusColor: Colors.blue,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      home: const CalendarScreen(),
    );
  }
}
