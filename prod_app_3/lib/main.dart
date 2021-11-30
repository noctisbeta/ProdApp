import 'package:flutter/material.dart';
import 'package:prod_app_3/providers/date_provider.dart';
// import 'package:prod_app_3/screens/calendar_screen.dart';
import 'package:prod_app_3/screens/menu_screen.dart';
import 'package:provider/provider.dart';
import 'providers/date_provider.dart';

// import 'screens/money_summary.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DateProvider(),
        )
      ],
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
        title: 'Productivity app',
        themeMode: ThemeMode.dark,
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: const Color(0xFFF2AEB4),
                secondary: const Color(0xFFF2AEB4),
              ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 60, 60, 60),
          textTheme: const TextTheme().apply(),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFF2AEB4),
              ),
            ),
            labelStyle: TextStyle(
              color: Color(0xFFF2AEB4),
            ),
          ),
        ),
        home: const MenuScreen(),
      ),
    );
  }
}
