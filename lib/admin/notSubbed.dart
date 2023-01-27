import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/admin/payment_page.dart';
import 'package:flutter_firebase_users/admin/widget/drawer.dart';

class NotSubbed extends StatelessWidget {
  const NotSubbed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        title: const Text("Admin"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 8,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    const Icon(
                      Icons.warning_amber_rounded,
                      size: 100,
                      color: Colors.red,
                    ),
                    const Text(
                      "Your subscription to SRVCS has expired.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Thus, you are now unable to receive or accomplish bookings using SRVCS.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "If you wish to re-subscribe to SRVCS, please click the 'Payments' button below.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PaymentPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Payments',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
