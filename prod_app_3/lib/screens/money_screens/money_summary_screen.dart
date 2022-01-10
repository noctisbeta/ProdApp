import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prod_app_3/screens/money_screens/money_month_summary_screen.dart';

import '../../database/database.dart';
import '../../database/money_event.dart';
import 'money_adding_screen.dart';
import 'money_crypto_screen.dart';

class MoneySummaryScreen extends StatefulWidget {
  final DateTime dateTime;
  final void Function({String? titleDate, String? titleType})
      changeTitleCallback;

  const MoneySummaryScreen({
    required this.dateTime,
    required this.changeTitleCallback,
    Key? key,
  }) : super(key: key);

  @override
  _MoneySummaryScreenState createState() => _MoneySummaryScreenState();
}

class _MoneySummaryScreenState extends State<MoneySummaryScreen> {
  final PageController pageCtl = PageController();

  Future<List<MoneyEvent>> getEvents() async {
    return DatabaseHelper.instance.getMoneyEvents(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageCtl,
      // onPageChanged: (index) {},
      onPageChanged: (index) {
        switch (index) {
          case 0:
            widget.changeTitleCallback(
              titleDate: DateFormat('EEEE').format(widget.dateTime),
              titleType: "'s Money",
            );
            break;
          case 1:
            widget.changeTitleCallback(
              titleDate: DateFormat.MMMM().format(widget.dateTime),
              titleType: "'s Money",
            );
            break;
          case 2:
            widget.changeTitleCallback(
              titleDate: '',
              titleType: 'Crypto',
            );
            break;
        }
      },
      children: [
        Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MoneyAddingScreen(
                      dateTime: widget.dateTime,
                    );
                  },
                ),
              ).then(
                (value) {
                  setState(() {});
                },
              );
            },
            child: const Icon(Icons.add),
          ),
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
        ),
        MoneyMonthSummaryScreen(
          dateTime: widget.dateTime,
        ),
        const CryptoScreen(),
      ],
    );
  }
}
