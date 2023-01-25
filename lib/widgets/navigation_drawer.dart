import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/main.dart';
import 'package:flutter_firebase_users/myhome.dart';
import 'package:flutter_firebase_users/navpages/booking_history.dart';
import '../navpages/active_booking.dart';
import '../navpages/contact-us_page.dart';
import '../consumer.dart';
import '../navpages/settings_page.dart';
import '../navpages/termsandconditions_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String email = "";
String firstName = "";
String lastName = "";
String phoneNumber = "";
String uid = "";

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});
  Future<void> _signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
      User? user = _auth.currentUser!;
      return await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();
    }

    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('some error occured'));
          }
          if (snapshot.hasData) {
            email = snapshot.data!['email'];
            firstName = snapshot.data!['first name'];
            uid = snapshot.data!['id'];
            lastName = snapshot.data!['last name'];
            phoneNumber = snapshot.data!['phone number'];

            return Drawer(
              child: Material(
                color: Colors.deepOrange,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    //home
                    buildMenuItem(
                        text: 'Home',
                        icon: Icons.home,
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ConsumerPage(),
                              ));
                        })),
                    const SizedBox(height: 10.0),
                    // terms and condition
                    buildMenuItem(
                        text: 'Active Booking',
                        icon: Icons.article_outlined,
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ActiveBookingPage(),
                              ));
                        })),
                    const SizedBox(height: 10.0),
                    //booking history
                    buildMenuItem(
                        text: 'Booking History',
                        icon: Icons.history,
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const BookingHistoryPage(),
                              ));
                        })),
                    const SizedBox(height: 10.0),
                    //contact us
                    buildMenuItem(
                        text: 'Contact Us',
                        icon: Icons.contacts,
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ContactUs(),
                              ));
                        })),
                    const SizedBox(height: 10.0),
                    //terms and condition
                    buildMenuItem(
                        text: 'Terms & Conditions',
                        icon: Icons.article_outlined,
                        onClicked: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TermsAndConditions(),
                              ));
                        })),
                    //added for logout -rob :)
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 30, 20),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          child: GestureDetector(
                            onTap: () {
                              _signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/main', (Route<dynamic> route) => false);
                            },
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
    Widget? child,
  }) {
    const color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      onTap: onClicked,
    );
  }
}
