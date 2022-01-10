import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../../database/money_event.dart';

class MoneyMonthSummaryScreen extends StatefulWidget {
  final DateTime dateTime;
  const MoneyMonthSummaryScreen({
    required this.dateTime,
    Key? key,
  }) : super(key: key);

  @override
  _MoneyMonthSummaryScreenState createState() =>
      _MoneyMonthSummaryScreenState();
}

class _MoneyMonthSummaryScreenState extends State<MoneyMonthSummaryScreen> {
  Future<List<MoneyEvent>> getEvents() async {
    return DatabaseHelper.instance.getMoneyEvents(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: FutureBuilder<List<MoneyEvent>>(
                  future: getEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const SizedBox.shrink();
                    }
                    if (!snapshot.hasData) {
                      return const SizedBox.shrink();
                    }
                    double sum_ = 0;
                    for (final e in snapshot.data!) {
                      sum_ += e.amount;
                    }
                    return Text(
                      '$sum_€',
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: FutureBuilder<List<MoneyEvent>>(
              future: getEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data!.isEmpty) {
                        return const SizedBox.shrink();
                      }
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
          ),
        ],
      ),
    );
  }
}
