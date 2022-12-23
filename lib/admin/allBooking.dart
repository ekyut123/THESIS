import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/admin/data_source/slot_DB.dart';

import 'widget/booking_tiles.dart';

class AllBookingPage extends StatelessWidget {
  const AllBookingPage({super.key, required this.date, required this.uid});
  final String uid;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
        ),
        body: Column(
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
                stream: SlotDB.readSlot(uid, date),
                builder: (context, snapshot) {
                  final slot = snapshot.data;
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No Ongoing Bookings on this day"),
                      );
                    } else {
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
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              bookingtile('Name: ',
                                                  '${slot[index].consumerfirstname} ${slot[index].consumerlastname}'),
                                              bookingtile(
                                                  'Service Name: ',
                                                  slot[index]
                                                      .sdchosenservicename),
                                              bookingtile('Date and Time: ',
                                                  slot[index].datetime),
                                              bookingtile('Email: ',
                                                  slot[index].consumeremail),
                                              bookingtile('Phone Number: ',
                                                  slot[index].consumerphonenum),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("BACK",
                                                  style: TextStyle(
                                                      color: Colors.grey)))
                                        ],
                                      );
                                    });
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ListTile(
                                    title:
                                        Text(slot[index].sdchosenservicename),
                                    subtitle: Text(
                                        '${slot[index].datetime} | ${slot[index].consumerfirstname} ${slot[index].consumerlastname}'),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("An Error Has Occured")));
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
