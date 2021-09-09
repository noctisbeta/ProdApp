import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';
import 'event_adding_page.dart';
import 'event.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({
    Key? key,
    this.event,
    
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text('Overview'),
        centerTitle: true,
        actions: buildEditingActions(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add, color: Colors.white),
      //   backgroundColor: Colors.blueGrey,
      //   onPressed: () => Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => EventAddingPage()),
      //   ),
      // ),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
              SizedBox(height: 12),
              buildDateTimePickers(),
            ],
          )));

  Widget buildTitle() => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
            border: UnderlineInputBorder(), hintText: 'Add Title'),
        onFieldSubmitted: (_) {},
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty' : null,
        controller: titleController,
      );

  Widget buildDateTimePickers() => Column(
    children: [
    ],
  );

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {},
            icon: Icon(Icons.done),
            label: Text('SAVE'))
      ];
}
