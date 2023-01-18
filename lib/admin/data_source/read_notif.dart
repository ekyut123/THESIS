import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/notif_model.dart';

class ReadNotif {
  static Stream <List<MessagesModel>> readmessages(String businessid){
    final messagescollection = FirebaseFirestore.instance
    .collection('Users')
    .doc(businessid)
    .collection('Mail');
    return messagescollection.snapshots().map((querySnapshot) =>
      querySnapshot.docs.map((e) => MessagesModel.fromSnapshot(e)).toList());
  }
}