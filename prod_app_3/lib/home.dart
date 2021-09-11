import 'package:flutter/material.dart';
// import 'package:prod_app_3/day_summary.dart';
import 'calendar_widget.dart';
// import 'event_editing_page.dart';
// import 'day_summary.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: CalendarWidget(),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add, color: Colors.white),
      //   backgroundColor: Colors.blueGrey,
      //   onPressed: () => Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => DaySummary()),
      //   ),
      // ),
    );
  }
}