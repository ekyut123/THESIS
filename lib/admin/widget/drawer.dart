import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/admin/admin.dart';
import 'package:flutter_firebase_users/admin/reports.dart';
import '../../navpages/contact-us_page.dart';
import '../../navpages/termsandconditions_page.dart';
import 'package:intl/intl.dart';

import '../messages.dart';
import '../payment_history.dart';
import '../payment_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String email = "";
String firstName = "";
String lastName = "";
String phoneNumber = "";
String uid = "";

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

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});
  Future<void> _signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
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
                        builder: (BuildContext context) => const AdminPage(),
                      ));
                })),
            const SizedBox(height: 10.0),
            buildMenuItem(
                text: 'Reports',
                icon: Icons.article_outlined,
                onClicked: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SummaryReport(
                          datetoday: date,
                        ),
                      ));
                })),
            const SizedBox(height: 10.0),
            buildMenuItem(
                text: 'Messages',
                icon: Icons.notifications_active,
                onClicked: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const MessagesWidget(),
                      ));
                })),
            const SizedBox(height: 10.0),
            buildMenuItem(
                text: 'Payments',
                icon: Icons.payment,
                onClicked: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const PaymentPage(),
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
                        builder: (BuildContext context) => const ContactUs(),
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
                        builder: (BuildContext context) => TermsAndConditions(),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
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
