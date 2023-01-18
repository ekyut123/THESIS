import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/admin/widget/app_minus_large_text.dart';
import '../admin/data_source/read_notif.dart';
import '../widgets/app_semi_large_text.dart';
import 'model/notif_model.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({super.key});

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

final String userid = FirebaseAuth.instance.currentUser!.uid;
final FirebaseAuth _auth = FirebaseAuth.instance;

late String title;
late String content;
late String date;

class _MessagesWidgetState extends State<MessagesWidget> {

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    User? user = _auth.currentUser!;
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
  }
  
  @override
  Widget build(BuildContext context) {

    void showMessageDetails(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(
              title.toUpperCase(),
              style: const TextStyle(color: Colors.deepOrange)
              ),
            content: Text(content),
            actions: [
              TextButton(style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              child: const Text(
                "Exit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop(const MessagesWidget());
                }
              )
            ],
          );
        });
    }
    
    return StreamBuilder<List<MessagesModel>>(
      stream: ReadNotif.readmessages(userid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text('some error occured'));
        }
        if(snapshot.hasData){
          final notif = snapshot.data;
            return Scaffold(
            appBar: AppBar(
              title: const Text("Messages"),
            ),
            body: ListView.builder(
              itemCount: notif!.length,
              itemBuilder: (context, index){
                return Card(
                  color: Colors.white70,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppMinusLargeText(text: notif[index].title),
                        AppSemiLargeText(text: notif[index].date),
                      ],
                    ),
                    subtitle: Text(notif[index].content),
                    onTap: () {
                      title = notif[index].title;
                      content = notif[index].content;
                      date = notif[index].date;

                      showMessageDetails();
                    },
                  ),

                );
              }
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
