import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveBooking {
  final String businessid;
  final String businessname;
  final String serviceid;
  final String servicename;
  final bool accomplished;
  final String timeslot;
  final int slot;
  final int timeStamp;
  final String datetime;

  const ActiveBooking({
    required this.businessid,
    required this.businessname,
    required this.serviceid,
    required this.servicename,
    required this.accomplished,
    required this.timeslot,
    required this.slot,
    required this.timeStamp,
    required this.datetime,
  });

  factory ActiveBooking.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ActiveBooking(
      accomplished: snapshot['accomplished'],
      businessid: snapshot['sdchosenbusinessid'],
      businessname: snapshot['sdchosenbusinessname'],
      serviceid: snapshot['sdchosenserviceid'],
      servicename: snapshot['sdchosenservicename'],
      timeStamp: snapshot['timeStamp'],
      timeslot: snapshot['timeslot'],
      datetime: snapshot['datetime'],
      slot: snapshot['slot'],
    );
  }

  Map<String, dynamic> toJson() => {
    "accomplished": accomplished,
    "sdchosenbusinessid": businessid,
    "sdchosenbusinessname": businessname,
    "sdchosenserviceid": serviceid,
    "sdchosenservicename": servicename,
    "slot": slot,
    "timeslot": timeslot,
    "timeStamp": timeStamp,
    "datetime" : datetime
  };
}
