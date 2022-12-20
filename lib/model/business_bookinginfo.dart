import 'package:cloud_firestore/cloud_firestore.dart';

class BookingInfo {
  final String sdchosenbusinessid;
  final String sdchosenserviceid;
  final String sdchosenservicename;
  final bool accomplished;
  final int slot;
  final String timeslot;
  final int timeStamp;

  const BookingInfo({
    required this.sdchosenbusinessid,
    required this.sdchosenserviceid,
    required this.sdchosenservicename,
    required this.accomplished,
    required this.slot,
    required this.timeslot,
    required this.timeStamp,
  });

  factory BookingInfo.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BookingInfo(
      sdchosenbusinessid: snapshot['sdchosenbusinessid'],
      sdchosenserviceid: snapshot['sdchosenserviceid'],
      sdchosenservicename: snapshot['sdchosenservicename'],
      accomplished: snapshot['accomplished'],
      slot: (snapshot['slot']),
      timeslot: (snapshot['timeslot']),
      timeStamp: (snapshot['timeStamp']),
    );
  }

  Map<String, dynamic> toJson() => {
        "sdchosenbusinessid": sdchosenbusinessid,
        "sdchosenserviceid": sdchosenserviceid,
        "sdchosenservicename": sdchosenservicename,
        "accomplished": accomplished,
        "slot": slot,
        "timeslot": timeslot,
        "timeStamp": timeStamp
      };
}
