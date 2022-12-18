import 'package:cloud_firestore/cloud_firestore.dart';

class BookingInfo {
  final String date;

  const BookingInfo({
    required this.date,
  });

  factory BookingInfo.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BookingInfo(date: snapshot['date']);
  }

  Map<String, dynamic> toJson() => {"date": date};
}
