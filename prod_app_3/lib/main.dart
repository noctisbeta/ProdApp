import 'package:flutter/material.dart';
import 'package:prod_app_3/screens/calendar_screen.dart';
import 'package:provider/provider.dart';
import 'database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => DatabaseModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      title: 'Productivity app',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
          // scaffoldBackgroundColor: Colors.black,
          accentColor: Colors.indigoAccent,
          primaryColor: Colors.transparent),
      home: const CalendarScreen(),
    );
  }
}
