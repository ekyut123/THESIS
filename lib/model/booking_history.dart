import 'package:cloud_firestore/cloud_firestore.dart';

class BookingHistory {
  final String docid;
  final String sdchosenbusinessid;
  final String sdchosenbusinessname;
  final String sdchosenserviceid;
  final String sdchosenservicename;
  final String datetime;
  final int slot;
  final int timeStamp;
  final String timeslot;
  final String date;
  final bool rated;

  const BookingHistory({
    required this.docid,
    required this.sdchosenbusinessid,
    required this.sdchosenbusinessname,
    required this.sdchosenserviceid,
    required this.sdchosenservicename,
    required this.timeslot,
    required this.slot,
    required this.timeStamp,
    required this.datetime,
    required this.date,
    required this.rated
  });

  factory BookingHistory.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BookingHistory(
      docid: snapshot['docid'],
      sdchosenbusinessid: snapshot['sdchosenbusinessid'],
      sdchosenbusinessname: snapshot['sdchosenbusinessname'],
      sdchosenserviceid: snapshot['sdchosenserviceid'],
      sdchosenservicename: snapshot['sdchosenservicename'],
      timeStamp: snapshot['timeStamp'],
      timeslot: snapshot['timeslot'],
      datetime: snapshot['datetime'],
      slot: snapshot['slot'],
      date: snapshot['date'],
      rated: snapshot['rated']
    );
  }

  Map<String, dynamic> toJson() => {
    "docid": docid,
    "sdchosenbusinessid": sdchosenbusinessid,
    "sdchosenbusinessname": sdchosenbusinessname,
    "sdchosenserviceid": sdchosenserviceid,
    "sdchosenservicename": sdchosenservicename,
    "timeStamp": timeStamp,
    "timeslot": timeslot,
    "datetime": datetime,
    "slot": slot,
    "date": date,
    "rated": rated
  };
}
