// ignore_for_file: unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/data_source/booking_DB.dart';
import 'package:flutter_firebase_users/model/booking_model.dart';

// ignore: camel_case_types, must_be_immutable
class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistory();
}

class _BookingHistory extends State<BookingHistory> {
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

            return Scaffold(
              appBar: AppBar(
                title: const Text("Booking History"),
              ),
              body: ListView.builder(
                  itemCount: booking!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListTile(title: Text(booking[index].date)),
                      ),
                    );
                  }),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
