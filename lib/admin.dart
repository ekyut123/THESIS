import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'data_source/booking_DB.dart';
import 'model/booking_model.dart';
// ignore: depend_on_referenced_packages

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  Future<void> _signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BookingInfo>>(
        stream: BookingDB.readbookinginfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('some error occured'));
          }
          if (snapshot.hasData) {
            final booking = snapshot.data;
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Admin"),
                  bottom: const TabBar(
                    indicator: BoxDecoration(color: Colors.orange),
                    tabs: [
                      Tab(text: "Today's Booking"),
                      Tab(text: "Tomorrow's Booking"),
                    ],
                  ),
                ),
                body: TabBarView(
                  // ignore: sort_child_properties_last
                  children: [
                    ListView.builder(
                        itemCount: booking!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: Container(
                              height: 150,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.deepOrange, Colors.orange],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              child: ListTile(
                                title: Text(booking[index].date),
                                textColor: Colors.white,
                              ),
                            ),
                          );
                        }),
                    ListView.builder(
                        itemCount: booking.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: Container(
                              height: 150,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.deepOrange, Colors.orange],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ]),
                              child: ListTile(
                                title: Text(booking[index].date),
                                textColor: Colors.white,
                              ),
                            ),
                          );
                        }),
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
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
