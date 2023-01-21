import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/widgets/app_semi_large_text.dart';
import '../data_source/read_DB.dart';
import '../navpages/resched_page.dart';
import '../widgets/app_large_text.dart';
import '../model/active_booking.dart';
import 'package:intl/intl.dart';

class ActiveBookingPage extends StatefulWidget {
  const ActiveBookingPage({super.key});

  @override
  State<ActiveBookingPage> createState() => _ActiveBookingPageState();
}

final String userid = FirebaseAuth.instance.currentUser!.uid;

//service booking info
String datetime = "";
String olddatetime = "";
String sdchosenbusinessid = "";
String sdchosenbusinessname = "";
String sdchosenservicename = "";
String sdchosenserviceid = "";
String timeslot = "";
String date = "";
String olddate = "";
int intslot = 0;
String slot = "";
String oldslot = "";
late String modeofpayment;

class _ActiveBookingPageState extends State<ActiveBookingPage> {

  // read booking details
  Future<DocumentSnapshot<Map<String, dynamic>>> readactivebookinginfo(String userid, String datetime) async{
      return await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Active Booking').doc(datetime).get();
  }
  //read business info
  Future<DocumentSnapshot<Map<String, dynamic>>> readbusinessinfo(String businessid) async{
      return await FirebaseFirestore.instance.collection('BusinessList').doc(businessid).get();
  }

  @override
  Widget build(BuildContext context) {
    
    void showConfirmedDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Booking Cancelled!'),
            content: const Text('Book to us again next time. Thank you!'),
            actions: [
              TextButton(style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              child: const Text(
                "Exit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop(const ActiveBookingPage());
                }
              )
            ],
          );
        });
    }
    
    void showCancelDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text(
              'Cancel Booking',
              style: TextStyle(
                color: Colors.deepOrange
              )
            ),
            content: const Text('Do you want to cancel the booking?'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text("No", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                }
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text("Yes", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userid)
                  .collection('Active Booking')
                  .doc(datetime)
                  .delete();

                  FirebaseFirestore.instance
                  .collection('BusinessList')
                  .doc(sdchosenbusinessid)
                  .collection('All Bookings')
                  .doc(date)
                  .collection('Slots')
                  .doc(slot)
                  .delete();
                  showConfirmedDialog();
                }
              )
            ],
          );
        }
      );
    }

    void showReschedDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text(
              'Reschedule Booking',
              style: TextStyle(
                color: Colors.deepOrange
              )
            ),
            content: const Text('Do you want to reschedule the booking?'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text("No", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                }
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text("Yes", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  final dt = DateTime.now();
                  final int DV = 0;
                  //day
                  final String dy = DateFormat.d().format(dt);
                  int intdy = int.tryParse(dy) ?? DV;
                  //month
                  final String month = DateFormat.MMM().format(dt);
                  final String nummonth = DateFormat.M().format(dt);
                  final int intmonth = int.tryParse(nummonth) ?? DV;
                  //year
                  final String yr = DateFormat.y().format(dt);
                  int intyr = int.tryParse(yr) ?? DV;
                  //get date tom
                  int intdytom = intdy + 1;
                  final String daytom = intdytom.toString();
                  final String date = "${daytom} ${month}, ${yr}";
                  
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReschedulePage(
                      chosenserviceid: sdchosenserviceid,
                      date: date,
                      intdy: intdytom,
                      intmonth: intmonth,
                      intyr: intyr,
                      olddatetime: olddatetime,
                      oldslot: oldslot,
                      olddate: olddate,
                    )
                  )
                );
              }
            )
          ],
        );
      });
    }
    
    void showMoreInfoDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
            future: readactivebookinginfo(userid, datetime),
            builder: (context, snapshot){
              if(snapshot.hasData){
                modeofpayment = snapshot.data!['modeofpayment'];
                datetime = snapshot.data!['datetime'];
                sdchosenbusinessid = snapshot.data!['sdchosenbusinessid'];
                sdchosenbusinessname = snapshot.data!['sdchosenbusinessname'];
                sdchosenserviceid = snapshot.data!['sdchosenserviceid'];
                sdchosenservicename = snapshot.data!['sdchosenservicename'];
                timeslot = snapshot.data!['timeslot'];
                date = snapshot.data!['date'];
                intslot = snapshot.data!['slot'];
                slot = intslot.toString();

                if(modeofpayment == 'gcash'){
                  return AlertDialog(
                  title: AppLargeText(text: 'Booking Details:'.toUpperCase()),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppLargeText(text: sdchosenbusinessname),
                      //business address
                      FutureBuilder(
                        future: readbusinessinfo(sdchosenbusinessid),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Text(snapshot.data!['business address']);
                          }
                          return const Center(child: CircularProgressIndicator());
                        }
                      ),
                      const SizedBox(height: 10),
                      //service name
                      Container(
                        color: Colors.white70,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.bookmark_add),
                            SizedBox(width: 5),
                            Text('Service: ', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(sdchosenservicename, textAlign: TextAlign.left),
                      ),
                      const SizedBox(height: 20),
                      //date time
                      Container(
                        color: Colors.white70,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 5),
                            Text(
                              'Date & Time: ',
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(datetime, textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 20),
                      //modeofpayment
                      Container(
                        color: Colors.white70,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.payment),
                            SizedBox(width: 5),
                            Text(
                              'Mode of Payment: ',
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(modeofpayment.toUpperCase(), textAlign: TextAlign.center),
                      ),
                    ]
                  ),
                  actions: [
                    //exit
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: const Text(
                        "Exit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(ActiveBookingPage);
                      }
                    ),
                    //resched
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: const Text(
                        "Reschedule",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        olddate = date;
                        olddatetime = datetime;
                        oldslot = slot;
                        Navigator.of(context).pop();
                        showReschedDialog();
                      }
                    ),
                  ],
                );
                }else{
                  return AlertDialog(
                  title: AppLargeText(text: 'Booking Details:'.toUpperCase()),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppLargeText(text: sdchosenbusinessname),
                      //business address
                      FutureBuilder(
                        future: readbusinessinfo(sdchosenbusinessid),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Text(snapshot.data!['business address']);
                          }
                          return const Center(child: CircularProgressIndicator());
                        }
                      ),
                      const SizedBox(height: 10),
                      //service name
                      Container(
                        color: Colors.white70,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.bookmark_add),
                            SizedBox(width: 5),
                            Text('Service: ', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(sdchosenservicename, textAlign: TextAlign.left),
                      ),
                      const SizedBox(height: 20),
                      //date time
                      Container(
                        color: Colors.white70,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 5),
                            Text(
                              'Date & Time: ',
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(datetime, textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 20),
                      //modeofpayment
                      Container(
                        color: Colors.white70,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.payment),
                            SizedBox(width: 5),
                            Text(
                              'Mode of Payment: ',
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(modeofpayment.toUpperCase(), textAlign: TextAlign.center),
                      ),
                    ]
                  ),
                  actions: [
                    //exit
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: const Text(
                        "Exit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(ActiveBookingPage);
                      }
                    ),
                    //cancel
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showCancelDialog();
                      }
                    ),
                    //resched
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: const Text(
                        "Reschedule",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        olddate = date;
                        olddatetime = datetime;
                        oldslot = slot;
                        Navigator.of(context).pop();
                        showReschedDialog();
                      }
                    ),
                  ],
                );
                }
              }
              return const Center(child: CircularProgressIndicator());
            }
          );
        }
      );
    }
    
    return StreamBuilder<List<ActiveBooking>>(
      stream: ReadDataBase.readactivebooking(userid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text('some error occured'));
        }
        if (snapshot.hasData){
          final activebooking = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Active Booking"),
              ),
              body: ListView.builder(
                  itemCount: activebooking!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white70,
                      child: ListTile(
                        title: AppSemiLargeText(text: activebooking[index].businessname),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(activebooking[index].servicename),
                            Text(activebooking[index].date),
                          ],
                        ),
                        trailing: ElevatedButton(
                          child: const Text('More Info'),
                          onPressed: () {
                            datetime = activebooking[index].datetime;
                            showMoreInfoDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black
                          ),
                        ),
                      ),
                    );
                  }),
            );
        }
        return const Center(child: CircularProgressIndicator());

      },
    );
  }
}
