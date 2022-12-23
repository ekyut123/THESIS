import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/allBooking_model.dart';

class AllBookingDB {
  static Stream<List<AllBookingInfo>> readAllBooking(String uid) {
    final slotscollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(uid)
        .collection('All Bookings');
    return slotscollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => AllBookingInfo.fromSnapshot(e)).toList());
  }
}
