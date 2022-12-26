import 'dart:ui';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContactUs extends StatelessWidget {
  const ContactUs({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text("Contact Us"),
        backgroundColor: Colors.teal[900],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 100.0,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/logo1.png'),
            ),
            // const Text(
            //   'Booking Services',
            //   style: TextStyle(
            //     fontFamily: 'Pacifico',
            //     fontSize: 40.0,
            //     color: Colors.white,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Text(
                ' Please let us know if you have any questions, feel free to contact us.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[100],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 45.0,
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  size: 24.0,
                  color: Colors.teal.shade800,
                ),
                title: Text(
                  '+63 927 667 2584',
                  style: TextStyle(
                    color: Colors.teal.shade800,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 45.0,
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  size: 24.0,
                  color: Colors.teal.shade800,
                ),
                title: Text(
                  'lipa.booking.services.inc@gmail.com',
                  style: TextStyle(
                    color: Colors.teal.shade800,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
