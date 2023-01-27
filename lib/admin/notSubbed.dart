import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
                "Your subscription to SRVCS has expired thus, you are now unable to receive or accomplish bookings using SRVCS. "),
            Text(
                "If you wish to re-subscribe to SRVCS, please go to the 'Payments' tab")
          ],
        )),
      ),
    );
  }
}
