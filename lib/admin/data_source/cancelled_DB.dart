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
}
