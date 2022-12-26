import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/consumer.dart';
import 'package:flutter_firebase_users/main.dart';
import 'package:flutter_firebase_users/navpages/active_booking.dart';
import 'package:flutter_firebase_users/widgets/app_semi_large_text.dart';
import '../data_source/read_DB.dart';
import '../model/b_bookinginfo.dart';
import '../utils.dart';
import '../widgets/app_large_text.dart';
import '../widgets/app_short_text.dart';
import '../widgets/navigation_drawer.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ReschedulePage extends StatefulWidget {
  final String chosenserviceid;
  final String olddatetime;
  final String oldslot;
  final String olddate;
  late String date;
  late int intdy;
  late int intmonth;
  late int intyr;

  ReschedulePage(
      {super.key,
      required this.chosenserviceid,
      required this.date,
      required this.intdy,
      required this.intmonth,
      required this.intyr,
      required this.olddatetime,
      required this.oldslot,
      required this.olddate,
    });

  @override
  State<ReschedulePage> createState() => _ReschedulePageState();
}

  //booking info
  String businessid = "";
  String businessloc = "";
  String categoryName = "";
  String serviceDescription = "";
  String serviceImage = "";
  String serviceName = "";
  String servicePrice= "";
  String serviceid = "";
  String businessName = "";
  String datetime = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String uid = "";

class _ReschedulePageState extends State<ReschedulePage> {

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    User? user = _auth.currentUser!;
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
  }
  //read service info
  Future<DocumentSnapshot<Map<String, dynamic>>> readservice(String serviceid) async{
      return await FirebaseFirestore.instance.collection('Services').doc(serviceid).get();
  }

  //read business info
  Future<DocumentSnapshot<Map<String, dynamic>>> readbusinessinfo(String businessid) async{
      return await FirebaseFirestore.instance.collection('BusinessList').doc(businessid).get();
  }

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
              Text('Thank you so much for re-booking!'),
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
                            builder: (BuildContext context) => const ConsumerPage()));
                  }),
            ],
          );
        });
  }

  void _showBookingInfo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
            future: readservice(widget.chosenserviceid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('some error occured'));
              }
              if(snapshot.hasData){
                businessid = snapshot.data!['businessid'];
                categoryName = snapshot.data!['categoryName'];
                serviceDescription = snapshot.data!['serviceDescription'];
                serviceImage = snapshot.data!['serviceImage'];
                serviceName = snapshot.data!['serviceName'];
                serviceid = snapshot.data!['serviceid'];
              
              return AlertDialog(
                // ignore: prefer_const_literals_to_create_immutables
                title: AppLargeText(text: 'Booking Info:'.toUpperCase()),
                content:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, children: [
                  FutureBuilder(
                    future: readbusinessinfo(businessid),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        businessName = snapshot.data!['businessName'];
                        return AppSemiLargeText(text: businessName);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }
                  ),
                  FutureBuilder(
                    future: readbusinessinfo(businessid),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return Text(snapshot.data!['business address']);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }
                  ),
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
                              'Service: ${categoryName}',
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
                      ' "${serviceName}" ',
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
                        Navigator.of(context).pop(ReschedulePage);
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
                        Navigator.of(context).pop();
                      }),
                ],
              );
              }
              return const Center(child: CircularProgressIndicator());
            }
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          email = snapshot.data!['email'];
          firstName = snapshot.data!['first name'];
          uid = snapshot.data!['id'];
          lastName = snapshot.data!['last name'];
          phoneNumber = snapshot.data!['phone number'];

          return FutureBuilder(
            future: readservice(widget.chosenserviceid),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                businessid = snapshot.data!['businessid'];
                categoryName = snapshot.data!['categoryName'];
                serviceDescription = snapshot.data!['serviceDescription'];
                serviceImage = snapshot .data!['serviceImage'];
                serviceName = snapshot.data!['serviceName'];
                servicePrice = snapshot.data!['servicePrice'];
                serviceid = snapshot.data!['serviceid'];
                print(serviceName);

                return FutureBuilder(
                  future: readbusinessinfo(businessid),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Scaffold(
                      floatingActionButton: FloatingActionButton.extended(
                        onPressed: selectedtime == '' ? null : () {
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
                        title: Text(businessName)
                      ),
                      body: SingleChildScrollView(
                        child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(color: Colors.grey[100]),
                              ),
                              //service name & price
                              Row(
                                children: [
                                  Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              padding: const EdgeInsets.only(left: 15, top: 10),
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppLargeText(text: serviceName),
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
                                                      text: "₱ ${servicePrice}", color: Colors.black),
                                                  const SizedBox(height: 5)
                                                ],
                                              ),
                                            ),
                                ],
                              ),
                              //service description
                              Container(
                                          height: MediaQuery.of(context).size.height * 0.10,
                                          padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                                          alignment: Alignment.topCenter,
                                          child: AppShortText(
                                              text: serviceDescription, color: Colors.black),
                                        ),
                              // selected time and date
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
                              //date & time picker
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: _datePicker(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: _timePicker(widget.date, widget.intmonth, widget.intdy, widget.intyr),
                              ),
                            ]
                          )
                      )     
                    );
                    }
                    return const Center(child: CircularProgressIndicator()); 
                  }
                );
              }
              return const Center(child: CircularProgressIndicator());
            }
          );
        }
        return const Center(child: CircularProgressIndicator()); 
      }
    );
  }

  Widget _datePicker() {
    final dt = DateTime.now();
    return DateTimePicker(
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

          //clicked date, month, day and year
          widget.date = _d1;
          widget.intmonth = intmonth;
          widget.intdy = intdy;
          widget.intyr = intyr;
        });
      },
    );
  }

  Widget _timePicker(String clickeddate, int month, int day, int year) {
    
    //start booking date
    final temp = DateTime.now();
    final String temp1 = DateFormat.d().format(temp);
    final String temp2 = DateFormat.M().format(temp);
    final String temp3 = DateFormat.y().format(temp);
    int inttemp1 = int.parse(temp1);
    inttemp1 = inttemp1 + 1;
    int inttemp2 = int.parse(temp2);
    int inttemp3 = int.parse(temp3);

    //if last year nagbook, unavailable
    if(year < inttemp3){
      return Container(
        height: MediaQuery.of(context).size.height * .8,
        child: Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: timeSlot.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4
            ),
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
                  )
                ),
              ),
            ),
          ),
        )
      );
    }
    //if same year --
    if(year == inttemp3){
      //pero last month nagbook, unavailable
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
      //then same month --
      if (month == inttemp2) {
        //pero kahapon, unavailable
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
                        )
                      ),
                    ),
                  ),
              ),
            )
          );
        }
        //this day forward, available
        else{
          return Container(
            height: MediaQuery.of(context).size.height * .8,
            child: StreamBuilder<List<BookingInfo>>(
              stream: ReadDataBase.readtimeslot(
                businessid, clickeddate),
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
                            crossAxisCount: 4
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: timeslots.contains(index) ? null : () {
                              setState(() {
                                selectedtime = timeSlot.elementAt(index);
                                intslot = index;
                                stringslot = intslot.toString();
                                //hour
                                hour = selectedtime.split(':')[0].substring(0, 2);
                                inthr = int.tryParse(hour) ?? DV;
                                //minuts
                                minute = selectedtime.split(':')[1].substring(0, 2);
                                intmin = int.tryParse(minute) ?? DV;
                              });
                            },
                            child: Card(
                              color: timeslots.contains(index) ? Colors.white10 : selectedtime == timeSlot.elementAt(index) ? Colors.deepOrange : Colors.white,
                              child: GridTile(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(timeSlot.elementAt(index),
                                        style: Theme.of(context).textTheme.overline
                                      ),
                                      Text(
                                        timeslots.contains(index) ? 'Full' : 'Available',
                                        style: Theme.of(context).textTheme.overline
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                          )
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            );
        }
      }
      // this month forward, available
      else{
        return Container(
          height: MediaQuery.of(context).size.height * .8,
          child: StreamBuilder<List<BookingInfo>>(
            stream: ReadDataBase.readtimeslot(
              businessid, clickeddate),
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
                        crossAxisCount: 4
                      ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: timeslots.contains(index) ? null : () {
                        setState(() {
                          selectedtime = timeSlot.elementAt(index);
                          intslot = index;
                          stringslot = intslot.toString();
                          //hour
                          hour = selectedtime.split(':')[0].substring(0, 2);
                          inthr = int.tryParse(hour) ?? DV;
                          //minuts
                          minute = selectedtime.split(':')[1].substring(0, 2);
                          intmin = int.tryParse(minute) ?? DV;
                        });
                      },
                      child: Card(
                        color: timeslots.contains(index) ? Colors.white10 : selectedtime == timeSlot.elementAt(index) ? Colors.deepOrange : Colors.white,
                        child: GridTile(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(timeSlot.elementAt(index),
                                  style: Theme.of(context).textTheme.overline
                                ),
                                Text(
                                  timeslots.contains(index) ? 'Full' : 'Available',
                                  style: Theme.of(context).textTheme.overline
                                )
                              ],
                            )
                          ),
                        ),
                      ),
                    )
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      );
      }
    }
    if(year > inttemp3){
      return Container(
        height: MediaQuery.of(context).size.height * .8,
        child: StreamBuilder<List<BookingInfo>>(
          stream: ReadDataBase.readtimeslot(
            businessid, clickeddate),
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
                        crossAxisCount: 4
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: timeslots.contains(index) ? null : () {
                          setState(() {
                            selectedtime = timeSlot.elementAt(index);
                            intslot = index;
                            stringslot = intslot.toString();
                            //hour
                            hour = selectedtime.split(':')[0].substring(0, 2);
                            inthr = int.tryParse(hour) ?? DV;
                            //minuts
                            minute = selectedtime.split(':')[1].substring(0, 2);
                            intmin = int.tryParse(minute) ?? DV;
                          });
                        },
                        child: Card(
                          color: timeslots.contains(index) ? Colors.white10 : selectedtime == timeSlot.elementAt(index) ? Colors.deepOrange : Colors.white,
                          child: GridTile(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(timeSlot.elementAt(index),
                                    style: Theme.of(context).textTheme.overline
                                  ),
                                  Text(
                                    timeslots.contains(index) ? 'Full' : 'Available',
                                    style: Theme.of(context).textTheme.overline
                                  )
                                ],
                              )
                            ),
                          ),
                        ),
                      )
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
    }
    return const Center(child: CircularProgressIndicator());
  }

  confirmBooking() {
    var timeStamp = DateTime(intyr, intmonth, intdy, inthr, intmin).millisecond;
    datetime = '$selectedtime - $_d1';
    
    // business admin
    var submitBookingInfo = {
      'sdchosenbusinessid': businessid,
      'sdchosenbusinessname': businessName,
      'sdchosenserviceid': widget.chosenserviceid,
      'sdchosenservicename': serviceName,
      'accomplished': false,
      'timeslot': selectedtime,
      'slot': intslot,
      'timeStamp': timeStamp,
      'datetime': datetime,
      'consumerid': uid,
      'consumeremail': email,
      'consumerfirstname': firstName,
      'consumerlastname': lastName,
      'consumerphonenum': phoneNumber
    };

    //consumer
    var submitActiveBooking = {
      'sdchosenbusinessid': businessid,
      'sdchosenbusinessname': businessName,
      'sdchosenserviceid': serviceid,
      'sdchosenservicename': serviceName,
      'accomplished': false,
      'timeslot': selectedtime,
      'slot': intslot,
      'timeStamp': timeStamp,
      'datetime': datetime,
      'date' : _d1
    };

    var setDate = {
      'date' : _d1
    };

    //Submit on Firestore Business check
    final firestorebusiness = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(businessid);
    
    CollectionReference bookingcollection = firestorebusiness.collection('All Bookings');
    bookingcollection.doc(_d1).set(setDate);
    bookingcollection = bookingcollection.doc(_d1)
    .collection('Slots');
    bookingcollection.doc(stringslot)
    .set(submitBookingInfo)
    .then((value) => {
      _showConfirmedDialog()
    });

    //Submit on Firestore Consumer hindi
    final firestoreconsumer = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid);
    CollectionReference userbookingcollection = firestoreconsumer.collection('Active Booking');
    userbookingcollection.doc(datetime)
    .set(submitActiveBooking);

    //Delete on Consumers Firestore hindi
    FirebaseFirestore.instance
    .collection('Users')
    .doc(uid)
    .collection('Active Booking')
    .doc(widget.olddatetime)
    .delete();

    //Delete on Business Firestore hindi
    FirebaseFirestore.instance
    .collection('BusinessList')
    .doc(businessid)
    .collection('All Bookings')
    .doc(widget.olddate)
    .collection('Slots')
    .doc(widget.oldslot)
    .delete();

  }
  
}
