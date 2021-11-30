import 'package:flutter/material.dart';
import '../widgets/menu_buttons.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  List<Widget> get buttons => const [
        CalendarButton(),
        MoneyButton(),
        TimeButton(),
        CalorieButton(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          return buttons[index];
        },
      ),
    );
  }
}
