import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/main.dart';
import '../data_source/business_DB.dart';
import '../model/business_bookinginfo.dart';
import '../utils.dart';
import '../widgets/app_large_text.dart';
import '../widgets/app_semi_large_text.dart';
import '../widgets/app_short_text.dart';
import '../widgets/navigation_drawer.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final String chosenbusinessid;
  final String chosenbusinessname;
  final String chosenbusinessloc;
  final String chosenserviceid;
  final String chosenservicename;
  final String serviceimage;
  final String serviceprice;
  final String serviceDescription;
  final String categoryName;
  late String date;
  late int intdy;
  late int intmonth;

  BookingPage(
      {super.key,
      required this.chosenbusinessid,
      required this.chosenservicename,
      required this.serviceimage,
      required this.serviceprice,
      required this.serviceDescription,
      required this.chosenbusinessname,
      required this.chosenserviceid,
      required this.categoryName,
      required this.chosenbusinessloc,
      required this.date,
      required this.intdy,
      required this.intmonth});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  //for date
  late String _d1 = "";
  late int intmonth;
  late int intdy;
  late int intyr;
  late var month = '';
  late var dy = '';
  late var yr = '';

  //for time
  late var selectedtime = '';
  late int inthr;
  late int intmin;
  late var hour = '';
  late var minute = '';

  late int intslot;
  late var stringslot = '';
  final int DV = 0;

  //submitdata
  final String sdchosenbusinessid = "";
  final String sdchosenbusinessname = "";
  final String sdchosenserviceid = "";
  final String sdchosenservicename = "";

  void _showConfirmedDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // ignore: prefer_const_literals_to_create_immutables
            title: Row(children: const [
              Text(
                'Confirmed!',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ]),
            content: Row(children: const [
              Text('Thank you so much for booking!'),
            ]),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const MyApp()));
                  }),
            ],
          );
        });
  }

  void _showBookingInfo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // ignore: prefer_const_literals_to_create_immutables
            title: Row(children: [
              AppLargeText(
                text: 'Booking Info:'.toUpperCase(),
              ),
            ]),
            content:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              AppSemiLargeText(text: widget.chosenbusinessname),
              Text(widget.chosenbusinessloc),
              const SizedBox(height: 10),
              Container(
                color: Colors.white70,
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.bookmark_add),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service: ${widget.categoryName}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5)
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  ' "${widget.chosenservicename}" ',
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white70,
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.calendar_today),
                    Column(
                      children: [
                        Text(
                          'Date: $_d1',
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Time: $selectedtime',
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(BookingPage);
                  }),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    confirmBooking();
                    Navigator.of(context).pop(_showConfirmedDialog);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: selectedtime == ''
              ? null
              : () {
                  _showBookingInfo();
                },
          label: const Text('Book'),
          icon: const Icon(Icons.book),
          backgroundColor: Colors.deepOrange,
        ),
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
            title: Text(widget.chosenservicename)),
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
                    AppLargeText(text: widget.chosenservicename),
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
                child: Text('$_d1 | $selectedtime',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _datePicker(),
                  _timePicker(widget.date, widget.intmonth, widget.intdy),
                ],
              ),
            ),
          ),
          const SizedBox(height: 65)
        ])));
  }

  Widget _datePicker() {
    final dt = DateTime.now();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DateTimePicker(
          type: DateTimePickerType.Date,
          initialSelectedDate: dt.add(const Duration(days: 1)),
          startDate: dt.subtract(const Duration(days: 1)),
          endDate: dt.add(const Duration(days: 30)),
          datePickerTitle: 'Pick a date',
          is24h: false,
          numberOfWeeksToDisplay: 4,
          onDateChanged: (date) {
            setState(() {
              _d1 = DateFormat('dd MMM, yyyy').format(date);
              month = DateFormat.M().format(date);
              dy = DateFormat.d().format(date);
              yr = DateFormat.y().format(date);
              intmonth = int.tryParse(month) ?? DV;
              intdy = int.tryParse(dy) ?? DV;
              intyr = int.tryParse(yr) ?? DV;

              widget.date = _d1;
              widget.intmonth = intmonth;
              widget.intdy = intdy;
            });
          },
        )
      ],
    );
  }

  Widget _timePicker(String clickeddate, int month, int day) {
    //start booking date
    final temp = DateTime.now();
    final String temp1 = DateFormat.d().format(temp);
    final String temp2 = DateFormat.M().format(temp);
    int inttemp1 = int.parse(temp1);
    inttemp1 = inttemp1 + 1;
    int inttemp2 = int.parse(temp2);
    print(inttemp1);

    if (month < inttemp2) {
      return Container(
          height: MediaQuery.of(context).size.height * .8,
          child: Expanded(
            child: GridView.builder(
              itemCount: timeSlot.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) => Card(
                color: Colors.white,
                child: GridTile(
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(timeSlot.elementAt(index),
                          style: Theme.of(context).textTheme.overline),
                      Text('Unavailable',
                          style: Theme.of(context).textTheme.overline)
                    ],
                  )),
                ),
              ),
            ),
          ));
    }
    if (month == inttemp2) {
      if (day < inttemp1) {
        return Container(
            height: MediaQuery.of(context).size.height * .8,
            child: Expanded(
              child: GridView.builder(
                itemCount: timeSlot.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  child: GridTile(
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(timeSlot.elementAt(index),
                            style: Theme.of(context).textTheme.overline),
                        Text('Unavailable',
                            style: Theme.of(context).textTheme.overline)
                      ],
                    )),
                  ),
                ),
              ),
            ));
      } else {
        return Container(
          height: MediaQuery.of(context).size.height * .8,
          child: StreamBuilder<List<BookingInfo>>(
            stream: BusinessListDB.readtimeslot(
                widget.chosenbusinessid, clickeddate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(child: Text('some error occured'));
              }
              if (snapshot.hasData) {
                final timeslotdata = snapshot.data;
                List<int> timeslots = [];
                timeslotdata?.forEach((element) {
                  timeslots.add(element.slot);
                });
                return Expanded(
                  child: GridView.builder(
                      itemCount: timeSlot.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: timeslots.contains(index)
                                ? null
                                : () {
                                    setState(() {
                                      selectedtime = timeSlot.elementAt(index);
                                      intslot = index;
                                      stringslot = intslot.toString();
                                      //hour
                                      hour = selectedtime
                                          .split(':')[0]
                                          .substring(0, 2);
                                      inthr = int.tryParse(hour) ?? DV;
                                      //minuts
                                      minute = selectedtime
                                          .split(':')[1]
                                          .substring(0, 2);
                                      intmin = int.tryParse(minute) ?? DV;
                                    });
                                  },
                            child: Card(
                              color: timeslots.contains(index)
                                  ? Colors.white10
                                  : selectedtime == timeSlot.elementAt(index)
                                      ? Colors.deepOrange
                                      : Colors.white,
                              child: GridTile(
                                child: Center(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(timeSlot.elementAt(index),
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline),
                                    Text(
                                        timeslots.contains(index)
                                            ? 'Full'
                                            : 'Available',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline)
                                  ],
                                )),
                              ),
                            ),
                          )),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      }
    }
    return const Center(child: CircularProgressIndicator());
  }

  confirmBooking() {
    var timeStamp = DateTime(intyr, intmonth, intdy, inthr, intmin).millisecond;

    var submitBookingData = {
      'sdchosenbusinessid': widget.chosenbusinessid,
      'sdchosenbusinessname': widget.chosenbusinessname,
      'sdchosenserviceid': widget.chosenserviceid,
      'sdchosenservicename': widget.chosenserviceid,
      'accomplished': false,
      'timeslot': selectedtime,
      'slot': intslot,
      'timeStamp': timeStamp,
      'datetime': '$selectedtime - $_d1'
    };

    var setAllBookings = {'name': "All Bookings"};

    //Submit on Firestore
    final firestore = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(widget.chosenbusinessid);
    CollectionReference bookingservices = firestore.collection('Bookings');
    bookingservices.doc('All Bookings').set(setAllBookings);

    CollectionReference newbooking =
        bookingservices.doc('All Bookings').collection(_d1);
    newbooking
        .doc(stringslot)
        .set(submitBookingData)
        .then((value) => {_showConfirmedDialog()});
  }
}
