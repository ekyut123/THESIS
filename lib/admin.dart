import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text(
//             "Welcome! Admin",
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Montserrat',
//               fontSize: 30,
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           SizedBox(
//             height: 40,
//             child: Material(
//               borderRadius: BorderRadius.circular(20),
//               shadowColor: Colors.greenAccent,
//               color: Colors.black,
//               elevation: 7,
//               child: GestureDetector(
//                 onTap: () async {
//                   _signOut();
//                 },
//                 child: const Center(
//                   child: Text(
//                     'LOGOUT',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Montserrat',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
  List<String> data = [
    "#1\nName\nService",
    "#2\nName\nService",
    "#3\nName\nService",
    "#4\nName\nService",
    "#5\nName\nService",
    "#6\nName\nService",
  ];

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  title: Text(data[index]),
                  trailing: const SizedBox(
                    width: 100,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
