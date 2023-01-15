import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/cancelled_model.dart';

class CancelledDB {
  static Stream<List<CancelledInfo>> readCancelled(String uid) {
    final slotscollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(uid)
        .collection('Cancelled')
        .orderBy('date', descending: false);
    return slotscollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => CancelledInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<CancelledInfo>> readCancelledDate(
      String uid, String date) {
    final datecollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(uid)
        .collection('Cancelled')
        .where('date', isEqualTo: date);
    return datecollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => CancelledInfo.fromSnapshot(e)).toList());
  }
}
