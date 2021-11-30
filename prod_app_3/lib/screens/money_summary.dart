import 'package:flutter/material.dart';

class MoneySummaryScreen extends StatefulWidget {
  const MoneySummaryScreen({Key? key}) : super(key: key);

  @override
  _MoneySummaryScreenState createState() => _MoneySummaryScreenState();
}

class _MoneySummaryScreenState extends State<MoneySummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 50),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 50),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
