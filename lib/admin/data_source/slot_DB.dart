import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/slot_model.dart';

class SlotDB {
  static Stream<List<SlotInfo>> readSlot(String uid, String date) {
    final slotscollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(uid)
        .collection('All Bookings')
        .doc(date)
        .collection('Slots')
        .orderBy('slot', descending: false);
    return slotscollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => SlotInfo.fromSnapshot(e)).toList());
  }
}
