import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/data_source/read_DB.dart';
import '../model/active_booking.dart';
import 'booking_page.dart';
import 'package:intl/intl.dart';

class ActiveBookingPage extends StatefulWidget {
  const ActiveBookingPage({super.key});

  @override
  State<ActiveBookingPage> createState() => _ActiveBookingPageState();
}

class _ActiveBookingPageState extends State<ActiveBookingPage> {

  @override
  Widget build(BuildContext context) {

    void showAlertDialog(context, index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.deepOrange,
      ),
      child: const Text(
        "Yes",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
           //booking.removeAt(index);
        });
      },
    );
    
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.deepOrange,
      ),
      child: const Text(
        "No",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Cancellation",
        style: TextStyle(color: Colors.deepOrange),
      ),
      content: const Text("Are you sure that you want to cancel your booking?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
    final String userid = FirebaseAuth.instance.currentUser!.uid;
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
                      color: Colors.deepOrange,
                      child: ListTile(
                        title: Text(activebooking[index].servicename),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //cancel
                            ElevatedButton(
                              onPressed: () {
                                showAlertDialog(context, index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors                
                                .white, //change for background color of the button
                                foregroundColor: Colors.black),
                                child: const Text('Cancel')),
                            const SizedBox(width: 8),
                            //resched
                            ElevatedButton(
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

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                               BookingPage(
                                                chosenserviceid: activebooking[index].serviceid,
                                                date: date,
                                                intdy: intdytom,
                                                intmonth: intmonth,
                                                intyr: intyr
                                              )));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, //change for background color of the button
                                    foregroundColor: Colors.black),
                                child: const Text(
                                    'Reschedule') //change for the text color of button
                                ),
                          ],
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
