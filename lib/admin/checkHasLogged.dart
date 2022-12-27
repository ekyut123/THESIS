import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_users/admin/admin.dart';
import 'package:flutter_firebase_users/admin/changePass.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class CheckHasLogged extends StatelessWidget {
  const CheckHasLogged({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    User? user = _auth.currentUser!;
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(snapshot.data!["has logged"]);
            if (snapshot.data!["has logged"] == '0') {
              return ChangePass();
            } else {
              return AdminPage();
            }
          }
        } else if (snapshot.hasError) {}
        return const CircularProgressIndicator();
      },
    ));
  }
}
