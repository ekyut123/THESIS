import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/admin/allBooking.dart';
import 'package:flutter_firebase_users/admin/data_source/accomplished_DB.dart';
import 'package:flutter_firebase_users/admin/data_source/allBooking_DB.dart';
import 'package:flutter_firebase_users/admin/data_source/cancelled_DB.dart';
import 'package:flutter_firebase_users/admin/data_source/slot_DB.dart';
import 'package:flutter_firebase_users/admin/notSubbed.dart';
import 'package:flutter_firebase_users/admin/widget/booking_tiles.dart';
import 'package:flutter_firebase_users/admin/widget/drawer.dart';
import 'package:intl/intl.dart';

// ignore: depend_on_referenced_packages

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

final dt = DateTime.now();
const int DV = 0;
//day
final String dy = DateFormat.d().format(dt);
int intdy = int.tryParse(dy) ?? DV;
//month
final String month = DateFormat.MMM().format(dt);
final String nummonth = DateFormat.M().format(dt);
final int intmonth = int.tryParse(nummonth) ?? DV;
//year
final String yr = DateFormat.y().format(dt);
//get date
final String date = "$intdy $month, $yr";

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  Future<void> _signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future deleteData(String uid, int slot, String date) async {
    try {
      await FirebaseFirestore.instance
          .collection("BusinessList")
          .doc(uid)
          .collection('All Bookings')
          .doc(date)
          .collection('Slots')
          .doc(slot.toString())
          .delete();
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future deleteActiveBooking(String customeruid, String datetime) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(customeruid)
          .collection('Active Booking')
          .doc(datetime)
          .delete();
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future storeBookingHistory(
      String date,
      String id,
      String datetime,
      String sdchosenbusinessid,
      String sdchosenbusinessname,
      String sdchosenserviceid,
      String sdchosenservicename,
      String timeslot,
      int slot,
      int timestamp,
      String modeofpayment,
      String receipt) async {
    bool rated = false;
    final docBookingHistory = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('Booking History')
        .doc();
    final bookinghistoryjson = {
      'modeofpayment': modeofpayment,
      'receipt': receipt,
      'date': date,
      'datetime': datetime,
      'sdchosenbusinessid': sdchosenbusinessid,
      'sdchosenbusinessname': sdchosenbusinessname,
      'sdchosenserviceid': sdchosenserviceid,
      'sdchosenservicename': sdchosenservicename,
      'slot': slot,
      'timeStamp': timestamp,
      'timeslot': timeslot,
      'docid': docBookingHistory.id,
      'rated': rated,
    };
    await docBookingHistory.set(bookinghistoryjson);
  }

  Future storeCancel(
      String date,
      String uid,
      String email,
      String fname,
      String id,
      String lname,
      String phone,
      String datetime,
      String sdchosenbusinessid,
      String sdchosenbusinessname,
      String sdchosenserviceid,
      String sdchosenservicename,
      String timeslot,
      int slot,
      int timestamp,
      String modeofpayment,
      String receipt) async {
    final docCancel = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(user!.uid)
        .collection('Cancelled')
        .doc();
    final canceljson = {
      'modeofpayment': modeofpayment,
      'receipt': receipt,
      'date': date,
      'consumeremail': email,
      'consumerfirstname': fname,
      'consumerid': id,
      'consumerlastname': lname,
      'consumerphonenum': phone,
      'datetime': datetime,
      'sdchosenbusinessid': sdchosenbusinessid,
      'sdchosenbusinessname': sdchosenbusinessname,
      'sdchosenserviceid': sdchosenserviceid,
      'sdchosenservicename': sdchosenservicename,
      'slot': slot,
      'timeStamp': timestamp,
      'timeslot': timeslot,
      'docid': docCancel.id
    };
    await docCancel.set(canceljson);
  }

  Future storeAccomplish(
      String date,
      String uid,
      String email,
      String fname,
      String id,
      String lname,
      String phone,
      String datetime,
      String sdchosenbusinessid,
      String sdchosenbusinessname,
      String sdchosenserviceid,
      String sdchosenservicename,
      String timeslot,
      int slot,
      int timestamp,
      String modeofpayment,
      String receipt,
      String price) async {
    final docAcc = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(user!.uid)
        .collection('Accomplished')
        .doc();
    final accjson = {
      'price': price,
      'modeofpayment': modeofpayment,
      'receipt': receipt,
      'date': date,
      'consumeremail': email,
      'consumerfirstname': fname,
      'consumerid': id,
      'consumerlastname': lname,
      'consumerphonenum': phone,
      'datetime': datetime,
      'sdchosenbusinessid': sdchosenbusinessid,
      'sdchosenbusinessname': sdchosenbusinessname,
      'sdchosenserviceid': sdchosenserviceid,
      'sdchosenservicename': sdchosenservicename,
      'slot': slot,
      'timeStamp': timestamp,
      'timeslot': timeslot,
      'docid': docAcc.id
    };
    await docAcc.set(accjson);
  }

  bool isSubbed = true;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        isSubbed = value.data()!['isSubbed'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSubbed
        ? DefaultTabController(
            length: 4,
            child: Scaffold(
              drawer: const AdminDrawer(),
              appBar: AppBar(
                title: const Text("Admin"),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: "Today's Bookings"),
                    Tab(text: "Ongoing Bookings"),
                    Tab(text: "Accomplished Bookings"),
                    Tab(text: "Cancelled Bookings"),
                  ],
                ),
              ),
              body: TabBarView(
                // ignore: sort_child_properties_last
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Center(
                            child: Text(
                          date,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: SlotDB.readSlot(user!.uid, date),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "You have no bookings today",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                );
                              } else {
                                final slot = snapshot.data;
                                return ListView.builder(
                                    itemCount: slot!.length,
                                    itemBuilder: (context, index) {
                                      return Material(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        bookingtile('Name: ',
                                                            '${slot[index].consumerfirstname} ${slot[index].consumerlastname}'),
                                                        bookingtile(
                                                            'Service Name: ',
                                                            slot[index]
                                                                .sdchosenservicename),
                                                        bookingtile(
                                                            'Date and Time: ',
                                                            slot[index]
                                                                .datetime),
                                                        bookingtile(
                                                            'Email: ',
                                                            slot[index]
                                                                .consumeremail),
                                                        bookingtile(
                                                            'Phone Number: ',
                                                            slot[index]
                                                                .consumerphonenum),
                                                        bookingtile(
                                                            'Mode of Payment',
                                                            slot[index]
                                                                .modeofpayment
                                                                .toUpperCase()),
                                                        slot[index].modeofpayment ==
                                                                'gcash'
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'GCash Receipt'),
                                                                        content:
                                                                            Image.network(slot[index].receipt),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text("Back"))
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: ListTile(
                                                                  title: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: const [
                                                                        Text(
                                                                          'Receipt : ',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        Text(
                                                                          'Click Here',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.blue,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )
                                                                      ]),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'BACK',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                    title: const Text(
                                                                        "Are you sure you want to cancel?"),
                                                                    content:
                                                                        const Text(
                                                                            "This action is irreversible"),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'BACK',
                                                                          style:
                                                                              TextStyle(color: Colors.grey),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await storeCancel(
                                                                                date,
                                                                                user!.uid,
                                                                                slot[index].consumeremail,
                                                                                slot[index].consumerfirstname,
                                                                                slot[index].consumerid,
                                                                                slot[index].consumerlastname,
                                                                                slot[index].consumerphonenum,
                                                                                slot[index].datetime,
                                                                                slot[index].sdchosenbusinessid,
                                                                                slot[index].sdchosenbusinessname,
                                                                                slot[index].sdchosenserviceid,
                                                                                slot[index].sdchosenservicename,
                                                                                slot[index].timeslot,
                                                                                slot[index].slot,
                                                                                slot[index].timeStamp,
                                                                                slot[index].modeofpayment,
                                                                                slot[index].receipt);
                                                                            await deleteActiveBooking(slot[index].consumerid,
                                                                                slot[index].datetime);
                                                                            await deleteData(
                                                                                user!.uid,
                                                                                slot[index].slot,
                                                                                date);
                                                                            if (!mounted) {
                                                                              return;
                                                                            }
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            "DELETE",
                                                                            style:
                                                                                TextStyle(color: Colors.red),
                                                                          ))
                                                                    ]);
                                                              },
                                                            );
                                                          },
                                                          child: const Text(
                                                            'DELETE',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                    title: const Text(
                                                                        "Accomplish this appointment?"),
                                                                    content:
                                                                        const Text(
                                                                            "This action is irreversible"),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'BACK',
                                                                          style:
                                                                              TextStyle(color: Colors.grey),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await storeAccomplish(
                                                                                date,
                                                                                user!.uid,
                                                                                slot[index].consumeremail,
                                                                                slot[index].consumerfirstname,
                                                                                slot[index].consumerid,
                                                                                slot[index].consumerlastname,
                                                                                slot[index].consumerphonenum,
                                                                                slot[index].datetime,
                                                                                slot[index].sdchosenbusinessid,
                                                                                slot[index].sdchosenbusinessname,
                                                                                slot[index].sdchosenserviceid,
                                                                                slot[index].sdchosenservicename,
                                                                                slot[index].timeslot,
                                                                                slot[index].slot,
                                                                                slot[index].timeStamp,
                                                                                slot[index].modeofpayment,
                                                                                slot[index].receipt,
                                                                                slot[index].price);
                                                                            await storeBookingHistory(
                                                                                date,
                                                                                slot[index].consumerid,
                                                                                slot[index].datetime,
                                                                                slot[index].sdchosenbusinessid,
                                                                                slot[index].sdchosenbusinessname,
                                                                                slot[index].sdchosenserviceid,
                                                                                slot[index].sdchosenservicename,
                                                                                slot[index].timeslot,
                                                                                slot[index].slot,
                                                                                slot[index].timeStamp,
                                                                                slot[index].modeofpayment,
                                                                                slot[index].receipt);
                                                                            await deleteActiveBooking(slot[index].consumerid,
                                                                                slot[index].datetime);
                                                                            await deleteData(
                                                                                user!.uid,
                                                                                slot[index].slot,
                                                                                date);
                                                                            if (!mounted) {
                                                                              return;
                                                                            }
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            "ACCOMPLISH",
                                                                            style:
                                                                                TextStyle(color: Colors.green),
                                                                          ))
                                                                    ]);
                                                              },
                                                            );
                                                          },
                                                          child: const Text(
                                                            'ACCOMPLISH',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: ListTile(
                                                title: Text(slot[index]
                                                    .sdchosenservicename),
                                                subtitle: Text(
                                                    '${slot[index].datetime} | ${slot[index].consumerfirstname} ${slot[index].consumerlastname}\nMode of Payment: ${slot[index].modeofpayment.toUpperCase()}'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            } else if (snapshot.hasError) {
                              const Center(
                                child: Text("An Error Has Occured"),
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      )
                    ],
                  ),
                  StreamBuilder(
                    stream: AllBookingDB.readAllBooking(user!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("No Ongoing Bookings"),
                          );
                        } else {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Center(
                                    child: Text(
                                  "Ongoing Appointment Dates: ${snapshot.data!.length}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Material(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllBookingPage(
                                                          date: snapshot
                                                              .data![index]
                                                              .date,
                                                          uid: user!.uid)));
                                        },
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: ListTile(
                                              title: Text(
                                                  snapshot.data![index].date),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      } else if (snapshot.hasError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("An Error Has Occured")));
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: AccomplisedDB.readAccomplised(user!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("You have no accomplished bookings"),
                          );
                        } else {
                          final accomplish = snapshot.data;
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Center(
                                    child: Text(
                                  "Accomplished Appointments: ${accomplish!.length}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: accomplish.length,
                                  itemBuilder: (context, index) {
                                    return Material(
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        bookingtile('Name: ',
                                                            '${accomplish[index].consumerfirstname} ${accomplish[index].consumerlastname}'),
                                                        bookingtile(
                                                            'Service Name: ',
                                                            accomplish[index]
                                                                .sdchosenservicename),
                                                        bookingtile(
                                                            'Date and Time: ',
                                                            accomplish[index]
                                                                .datetime),
                                                        bookingtile(
                                                            'Email: ',
                                                            accomplish[index]
                                                                .consumeremail),
                                                        bookingtile(
                                                            'Phone Number: ',
                                                            accomplish[index]
                                                                .consumerphonenum),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "BACK",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)))
                                                  ],
                                                );
                                              });
                                        },
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: ListTile(
                                              title: Text(accomplish[index]
                                                  .sdchosenservicename),
                                              subtitle: Text(
                                                  '${accomplish[index].datetime} | ${accomplish[index].consumerfirstname} ${accomplish[index].consumerlastname}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      } else if (snapshot.hasError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("An Error Has Occured")));
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: CancelledDB.readCancelled(user!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("You have no cancelled bookings"),
                          );
                        } else {
                          final cancelled = snapshot.data;
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Center(
                                    child: Text(
                                  "Cancelled Appointments: ${cancelled!.length}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: cancelled.length,
                                  itemBuilder: (context, index) {
                                    return Material(
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        bookingtile('Name: ',
                                                            '${cancelled[index].consumerfirstname} ${cancelled[index].consumerlastname}'),
                                                        bookingtile(
                                                            'Service Name: ',
                                                            cancelled[index]
                                                                .sdchosenservicename),
                                                        bookingtile(
                                                            'Date and Time: ',
                                                            cancelled[index]
                                                                .datetime),
                                                        bookingtile(
                                                            'Email: ',
                                                            cancelled[index]
                                                                .consumeremail),
                                                        bookingtile(
                                                            'Phone Number: ',
                                                            cancelled[index]
                                                                .consumerphonenum),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "BACK",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)))
                                                  ],
                                                );
                                              });
                                        },
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: ListTile(
                                              title: Text(cancelled[index]
                                                  .sdchosenservicename),
                                              subtitle: Text(
                                                  '${cancelled[index].datetime} | ${cancelled[index].consumerfirstname} ${cancelled[index].consumerlastname}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      } else if (snapshot.hasError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("An Error Has Occured")));
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  _signOut();
                },
                label: const Text(
                  'Logout',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                ),
                icon: const Icon(Icons.logout),
                backgroundColor: Colors.deepOrange,
              ),
            ))
        : const NotSubbed();
  }
}
