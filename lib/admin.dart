import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Future<void> _signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    List<String> data = [
      "2022-11-07\njericho@gmail.com\nHighlights (bleach) premium",
      "2022-11-05\noba@gmail.com\nMake-up",
      "2022-12-07\nrobynn@gmail.com\nHaircut",
      "2022-11-15\nvon@gmail.com\nHaircut",
      "2022-11-10\necho@gmail.com\nHaircut",
    ];
    // ignore: unused_local_variable
    final sortedData = data.sort((a, b) => a.compareTo(b));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    title: Text(data[index]),
                    textColor: Colors.white,
                  ),
                ),
              );
            }),
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
        ));
  }
}
