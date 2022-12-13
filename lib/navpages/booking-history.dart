// ignore_for_file: unnecessary_new
import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistory();
}

class _BookingHistory extends State<BookingHistory> {
  List<String> data = [
    "#1\nName",
    "#2\nName",
    "#3\nName",
    "#4\nName",
    "#5\nName",
    "#6\nName",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Booking"),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.deepOrange,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(title: Text(data[index])),
              ),
            );
          }),
    );
  }
}
