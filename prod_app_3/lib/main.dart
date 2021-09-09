import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prod_app_3/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
          // scaffoldBackgroundColor: Colors.black,
          accentColor: Colors.indigoAccent,
          primaryColor: Colors.transparent),
      home: Home(),
    );
  }
}
