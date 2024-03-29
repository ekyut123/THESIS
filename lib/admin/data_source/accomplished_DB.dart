import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/accomplished_model.dart';

class AccomplisedDB {
  static Stream<List<AccomplisedInfo>> readAccomplised(String uid) {
    final slotscollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(uid)
        .collection('Accomplished')
        .orderBy('date', descending: false);
    return slotscollection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((e) => AccomplisedInfo.fromSnapshot(e))
        .toList());
  }

  static Stream<List<AccomplisedInfo>> readAccomplisedDate(
      String uid, String date) {
    final datecollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(uid)
        .collection('Accomplished')
        .where('date', isEqualTo: date);
    return datecollection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((e) => AccomplisedInfo.fromSnapshot(e))
        .toList());
  }
}
