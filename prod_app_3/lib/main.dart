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
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
        title: 'Productivity app',
        themeMode: ThemeMode.dark,
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: const Color(0xFFF2AEB4),
                secondary: const Color(0xFFaef1eb),
              ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 60, 60, 60),
          textTheme: const TextTheme().copyWith(
            bodyText1: const TextStyle(
              color: Colors.blue,
            ),
            bodyText2: const TextStyle(
              color: Colors.white,
            ),
            button: const TextStyle(
              color: Colors.green,
            ),
            caption: const TextStyle(
              color: Color(0xFFF2AEB4),
            ),
            headline1: const TextStyle(
              color: Colors.red,
            ),
            headline2: const TextStyle(
              color: Colors.red,
            ),
            headline3: const TextStyle(
              color: Colors.red,
            ),
            headline4: const TextStyle(
              color: Colors.red,
            ),
            headline5: const TextStyle(
              color: Colors.red,
            ),
            headline6: const TextStyle(
              color: Colors.red,
            ),
            overline: const TextStyle(
              color: Color(0xFFF2AEB4),
            ),
            subtitle1: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            subtitle2: const TextStyle(
              color: Colors.blue,
            ),
          ),
          timePickerTheme: const TimePickerThemeData(
            dialBackgroundColor: Color(0xFFF2AEB4),
            dialHandColor: Colors.white,
            dialTextColor: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFF2AEB4)),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            helperStyle: TextStyle(
              color: Color(0xFFF2AEB4),
            ),
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
