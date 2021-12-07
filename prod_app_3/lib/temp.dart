// Column(
      //   children: [
      //     Expanded(
      //       child: Stack(
      //         children: [
      //           Container(
      //             margin: const EdgeInsets.all(20),
      //             padding: const EdgeInsets.all(20),
      //             decoration: BoxDecoration(
      //               color: Theme.of(context).colorScheme.primary,
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //             child: Column(
      //               children: [
      //                 const Expanded(
      //                   child: Align(
      //                     alignment: Alignment.topCenter,
      //                     child: Text(
      //                       'Total',
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 const Spacer(),
      //                 Expanded(
      //                   child: FutureBuilder<int>(
      //                     future: getTotal(),
      //                     builder: (context, snapshot) {
      //                       if (snapshot.hasData) {
      //                         return Text(
      //                           '${snapshot.data!} kcal',
      //                           style: const TextStyle(
      //                             fontSize: 30,
      //                           ),
      //                         );
      //                       } else if (snapshot.hasError) {
      //                         return const Text('database empty');
      //                       } else {
      //                         return Center(
      //                           child: Column(
      //                             children: const [
      //                               CircularProgressIndicator(),
      //                               Padding(
      //                                 padding: EdgeInsets.only(top: 16),
      //                                 child: Text('Awaiting result...'),
      //                               ),
      //                             ],
      //                           ),
      //                         );
      //                       }
      //                     },
      //                   ),
      //                 ),
      //                 const Spacer()
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       color: Theme.of(context).colorScheme.primary,
      //     ),
      //     Expanded(
      //       child: FutureBuilder<List<CalorieEvent>>(
      //         future: getEvents(),
      //         builder: (context, snapshot) {
      //           if (snapshot.hasData) {
      //             final List<CalorieEvent> breakfast = snapshot.data!
      //                 .where((e) => e.meal == 'Breakfast')
      //                 .toList();
      //             final List<CalorieEvent> lunch =
      //                 snapshot.data!.where((e) => e.meal == 'Lunch').toList();
      //             final List<CalorieEvent> dinner =
      //                 snapshot.data!.where((e) => e.meal == 'Dinner').toList();
      //             final List<CalorieEvent> snack =
      //                 snapshot.data!.where((e) => e.meal == 'Snack').toList();
      //             final Set<String> meals = {};
      //             if (breakfast.isNotEmpty) {
      //               meals.add('breakfast');
      //             }
      //             if (lunch.isNotEmpty) {
      //               meals.add('lunch');
      //             }
      //             if (dinner.isNotEmpty) {
      //               meals.add('dinner');
      //             }
      //             if (snack.isNotEmpty) {
      //               meals.add('snack');
      //             }

      //             final List<CalorieEvent> toRender = [
      //               ...breakfast,
      //               ...lunch,
      //               ...dinner,
      //               ...snack,
      //             ];

      //             final List<bool> renderFlags = [false, false, false, false];

      //             return Column(
      //               children: [
      //                 Expanded(
      //                   child: Align(
      //                     alignment: Alignment.topLeft,
      //                     child: Container(
      //                       margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      //                       padding: const EdgeInsets.all(12),
      //                       decoration: BoxDecoration(
      //                         // color: Theme.of(context).colorScheme.primary,
      //                         color: const Color(0xFFaef1eb),
      //                         borderRadius: BorderRadius.circular(15),
      //                       ),
      //                       child: const Text(
      //                         'Breakfast',
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: ListView.builder(
      //                     shrinkWrap: true,
      //                     physics: const ClampingScrollPhysics(),
      //                     scrollDirection: Axis.horizontal,
      //                     itemCount: breakfast.length,
      //                     itemBuilder: (context, index) {
      //                       return Row(
      //                         children: [
      //                           const Spacer(
      //                             flex: 3,
      //                           ),
      //                           Expanded(
      //                             child: Icon(
      //                               Icons.remove,
      //                               color:
      //                                   Theme.of(context).colorScheme.primary,
      //                             ),
      //                           ),
      //                           // const Spacer(),
      //                           Expanded(
      //                             flex: 18,
      //                             child: Container(
      //                               margin:
      //                                   const EdgeInsets.fromLTRB(20, 5, 20, 5),
      //                               padding: const EdgeInsets.all(8),
      //                               decoration: BoxDecoration(
      //                                 color:
      //                                     Theme.of(context).colorScheme.primary,
      //                                 borderRadius: BorderRadius.circular(50),
      //                               ),
      //                               child: Row(
      //                                 children: [
      //                                   Text(breakfast[index].foodName),
      //                                   Text(
      //                                       ' (${breakfast[index].foodAmount})'),
      //                                   const Spacer(),
      //                                   Text(
      //                                     '${breakfast[index].calories * breakfast[index].foodAmount}kcal',
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       );
      //                     },
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Align(
      //                     alignment: Alignment.topLeft,
      //                     child: Container(
      //                       margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      //                       padding: const EdgeInsets.all(12),
      //                       decoration: BoxDecoration(
      //                         // color: Theme.of(context).colorScheme.primary,
      //                         color: const Color(0xFFaef1eb),
      //                         borderRadius: BorderRadius.circular(15),
      //                       ),
      //                       child: const Text(
      //                         'Lunch',
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Align(
      //                     alignment: Alignment.topLeft,
      //                     child: Container(
      //                       margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      //                       padding: const EdgeInsets.all(12),
      //                       decoration: BoxDecoration(
      //                         // color: Theme.of(context).colorScheme.primary,
      //                         color: const Color(0xFFaef1eb),
      //                         borderRadius: BorderRadius.circular(15),
      //                       ),
      //                       child: const Text(
      //                         'Dinner',
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Align(
      //                     alignment: Alignment.topLeft,
      //                     child: Container(
      //                       margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      //                       padding: const EdgeInsets.all(12),
      //                       decoration: BoxDecoration(
      //                         // color: Theme.of(context).colorScheme.primary,
      //                         color: const Color(0xFFaef1eb),
      //                         borderRadius: BorderRadius.circular(15),
      //                       ),
      //                       child: const Text(
      //                         'Snacks',
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             );
      //             // return ListView.builder(
      //             //   shrinkWrap: true,
      //             //   itemCount: toRender.length,
      //             //   itemBuilder: (context, index) {
      //             //     return Column(
      //             //       children: [
      //             // Align(
      //             //   alignment: Alignment.topLeft,
      //             //   child: Container(
      //             //     margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      //             //     padding: const EdgeInsets.all(12),
      //             //     decoration: BoxDecoration(
      //             //       // color: Theme.of(context).colorScheme.primary,
      //             //       color: const Color(0xFFaef1eb),
      //             //       borderRadius: BorderRadius.circular(15),
      //             //     ),
      //             //     child: const Text(
      //             //       'Breakfast',
      //             //       style: TextStyle(
      //             //         color: Colors.black,
      //             //       ),
      //             //     ),
      //             //   ),
      //             // ),
      //             // Row(
      //             //   children: [
      //             //     const Spacer(
      //             //       flex: 3,
      //             //     ),
      //             //     Expanded(
      //             //       child: Icon(
      //             //         Icons.remove,
      //             //         color: Theme.of(context).colorScheme.primary,
      //             //       ),
      //             //     ),
      //             //     // const Spacer(),
      //             //     Expanded(
      //             //       flex: 18,
      //             //       child: Container(
      //             //         margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      //             //         padding: const EdgeInsets.all(8),
      //             //         decoration: BoxDecoration(
      //             //           color: Theme.of(context).colorScheme.primary,
      //             //           borderRadius: BorderRadius.circular(50),
      //             //         ),
      //             //         child: Row(
      //             //           children: [
      //             //             Text(breakfast[index].foodName),
      //             //             Text(' (${breakfast[index].foodAmount})'),
      //             //             const Spacer(),
      //             //             Text(
      //             //               '${breakfast[index].calories * snapshot.data![index].foodAmount}kcal',
      //             //             ),
      //             //           ],
      //             //         ),
      //             //       ),
      //             //     ),
      //             //   ],
      //             // ),
      //             //       ],
      //             //     );
      //             //   },
      //             // );
      //           } else if (snapshot.hasError) {
      //             return const Text('database error');
      //           } else {
      //             return Center(
      //               child: Column(
      //                 children: const [
      //                   CircularProgressIndicator(),
      //                   Padding(
      //                     padding: EdgeInsets.only(top: 16),
      //                     child: Text('Awaiting result...'),
      //                   ),
      //                 ],
      //               ),
      //             );
      //           }
      //         },
      //       ),
      //     ),
      //     ///////////////////////////////////////////////////////
      //     // FutureBuilder<List<CalorieEvent>>(
      //     //   future: getEvents(),
      //     //   builder: (
      //     //     BuildContext context,
      //     //     AsyncSnapshot<List<CalorieEvent>> snapshot,
      //     //   ) {
      //     //     if (snapshot.hasData) {
      //     //       return Expanded(
      //     //         child: ListView.builder(
      //     //           itemCount: snapshot.data?.length,
      //     //           itemBuilder: (context, index) {
      //     // return Container(
      //     //   margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      //     //   padding: const EdgeInsets.all(15),
      //     //   decoration: BoxDecoration(
      //     //     color: Theme.of(context).colorScheme.primary,
      //     //     borderRadius: BorderRadius.circular(15),
      //     //   ),
      //     //   child: Row(
      //     //     children: [
      //     //       Text(snapshot.data![index].foodName),
      //     //       Text(' (${snapshot.data![index].foodAmount})'),
      //     //       const Spacer(),
      //     //       Text(
      //     //         '${snapshot.data![index].calories * snapshot.data![index].foodAmount}kcal',
      //     //       ),
      //     //     ],
      //     //   ),
      //     // );
      //     //     },
      //     //   ),
      //     // );
      //     //     } else if (snapshot.hasError) {
      //     //       return const Text('database error');
      //     //     } else {
      //     //       return Center(
      //     //         child: Column(
      //     //           children: const [
      //     //             CircularProgressIndicator(),
      //     //             Padding(
      //     //               padding: EdgeInsets.only(top: 16),
      //     //               child: Text('Awaiting result...'),
      //     //             ),
      //     //           ],
      //     //         ),
      //     //       );
      //     //     }
      //     //   },
      //     // ),
      //     /////////////////////////////////////////////////////
      //   ],
      // ),
