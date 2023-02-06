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
  final String date;
  final String modeofpayment;
  final String receipt;
  final int intdy;
  final int intmonth;
  final int intyr;


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
    required this.date,
    required this.modeofpayment,
    required this.receipt,
    required this.intdy,
    required this.intmonth,
    required this.intyr
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
      date: snapshot['date'],
      modeofpayment: snapshot['modeofpayment'],
      receipt: snapshot['receipt'],
      intdy: snapshot['intdy'],
      intmonth: snapshot['intmonth'],
      intyr: snapshot['intyr']
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
    "datetime" : datetime,
    "date" : date,
    "modeofpayment": modeofpayment,
    "receipt": receipt,
    "intdy": intdy,
    "intmonth": intmonth,
    "intyr": intyr
  };
}
