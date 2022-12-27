import 'package:cloud_firestore/cloud_firestore.dart';

class AllBookingInfo {
  final String date;

  const AllBookingInfo({required this.date});

  factory AllBookingInfo.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AllBookingInfo(date: snapshot['date']);
  }

  // Map<String, dynamic> toJson() => {"date": date};
}
