import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/database.dart';
import '../database/money_event.dart';
import '../widgets/menu_buttons.dart';

class MoneySummaryScreen extends StatefulWidget {
  final DateTime dateTime;
  const MoneySummaryScreen({
    required this.dateTime,
    Key? key,
  }) : super(key: key);

  @override
  _MoneySummaryScreenState createState() => _MoneySummaryScreenState();
}

class _MoneySummaryScreenState extends State<MoneySummaryScreen> {
  Future<List<MoneyEvent>> getEvents() async {
    return DatabaseHelper.instance.getMoneyEvents(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          CalendarAppBar(
            screenName: 'money',
          ),
        ],
        title: Text("${DateFormat('EEEE').format(widget.dateTime)}'s Money"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const SizedBox(
              height: 50,
              child: Align(
                child: Text('line'),
              ),
            ),
          ),
          FutureBuilder<List<MoneyEvent>>(
            future: getEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text(snapshot.data![index].location),
                          const Spacer(),
                          Text(snapshot.data![index].amount.toString()),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Text('database empty');
              } else {
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
