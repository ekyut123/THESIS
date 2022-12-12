import 'package:flutter/material.dart';
import '../widgets/app_large_text.dart';
import '../widgets/app_short_text.dart';
import '../widgets/navigation_drawer.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final String name;
  final String serviceimage;
  final String serviceprice;
  final String serviceDescription;

  const BookingPage({
    super.key,
    required this.name,
    required this.serviceimage,
    required this.serviceprice,
    required this.serviceDescription,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late String _d1 = "";
  late String _t1 = "";

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // ignore: prefer_const_literals_to_create_immutables
            title: Row(children: [
              const Text(
                //dito lalabas yung pinabook ng user.
                'Confirmation!',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ]),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            _showDialog();
          },
          label: const Text('Book'),
          icon: const Icon(Icons.book),
          backgroundColor: Colors.deepOrange,
        ),
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
            title: Text(widget.name)),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(color: Colors.grey[100]),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                padding: const EdgeInsets.only(left: 15, top: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppLargeText(text: widget.name),
                    const SizedBox(height: 5)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                padding: const EdgeInsets.only(right: 15, top: 20),
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShortText(
                        text: "₱ ${widget.serviceprice}", color: Colors.black),
                    const SizedBox(height: 5)
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
            alignment: Alignment.topCenter,
            child: AppShortText(
                text: widget.serviceDescription, color: Colors.black),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width * .5,
                alignment: Alignment.topLeft,
                child: Text('Selected Time and Date: ',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Container(
                padding: const EdgeInsets.only(right: 15),
                width: MediaQuery.of(context).size.width * .5,
                alignment: Alignment.topRight,
                child: Text('$_d1 | $_t1',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _dateTimePicker(),
                  ],
                ),
              ),
            ),
          )
        ])));
  }

  Widget _dateTimePicker() {
    final dt = DateTime.now();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DateTimePicker(
          initialSelectedDate: dt.add(const Duration(days: 1)),
          startDate: dt.subtract(const Duration(days: 1)),
          endDate: dt.add(const Duration(days: 60)),
          startTime: DateTime(dt.year, dt.month, dt.day, 9),
          endTime: DateTime(dt.year, dt.month, dt.day, 21),
          timeInterval: const Duration(minutes: 30),
          datePickerTitle: 'Pick a date',
          timePickerTitle: 'Pick a time',
          is24h: false,
          numberOfWeeksToDisplay: 4,
          onDateChanged: (date) {
            setState(() {
              _d1 = DateFormat('dd MMM, yyyy').format(date);
            });
          },
          onTimeChanged: (time) {
            setState(() {
              _t1 = DateFormat('hh:mm:ss aa').format(time);
            });
          },
        )
      ],
    );
  }
}
