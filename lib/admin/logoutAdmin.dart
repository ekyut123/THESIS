import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LogoutAfter extends StatefulWidget {
  const LogoutAfter({super.key});

  @override
  State<LogoutAfter> createState() => _LogoutAfterState();
}

class _LogoutAfterState extends State<LogoutAfter> {
  Future<void> _signOut() async {
    print("here");
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: const Text(
                  "Click logout and log back in with your new password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: SizedBox(
              width: 200,
              height: 40,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('Please re-log to your account',
                            style: TextStyle(color: Colors.black)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/main', (Route<dynamic> route) => false);
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Material(
                  shadowColor: Colors.greenAccent,
                  color: Colors.black,
                  elevation: 7,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
