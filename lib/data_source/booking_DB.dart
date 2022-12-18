import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_users/model/booking_model.dart';

class BookingDB {
  static Stream<List<BookingInfo>> readbookinginfo() {
    final businessinfocollection =
        FirebaseFirestore.instance.collection('users');
    return businessinfocollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BookingInfo.fromSnapshot(e)).toList());
  }
}
