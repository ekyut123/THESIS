import 'package:cloud_firestore/cloud_firestore.dart';

class SlotInfo {
  final bool accomplished;
  final String consumeremail,
      consumerid,
      consumerlastname,
      consumerfirstname,
      consumerphonenum,
      datetime,
      sdchosenbusinessid,
      sdchosenbusinessname,
      sdchosenserviceid,
      sdchosenservicename,
      timeslot;
  final int slot, timeStamp;

  const SlotInfo(
      {required this.accomplished,
      required this.consumeremail,
      required this.consumerid,
      required this.consumerlastname,
      required this.consumerfirstname,
      required this.consumerphonenum,
      required this.datetime,
      required this.sdchosenbusinessid,
      required this.sdchosenbusinessname,
      required this.sdchosenserviceid,
      required this.sdchosenservicename,
      required this.slot,
      required this.timeStamp,
      required this.timeslot});

  factory SlotInfo.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SlotInfo(
        accomplished: snapshot['accomplished'],
        consumeremail: snapshot['consumeremail'],
        consumerid: snapshot['consumerid'],
        consumerlastname: snapshot['consumerlastname'],
        consumerfirstname: snapshot['consumerfirstname'],
        consumerphonenum: snapshot['consumerphonenum'],
        datetime: snapshot['datetime'],
        sdchosenbusinessid: snapshot['sdchosenbusinessid'],
        sdchosenbusinessname: snapshot['sdchosenbusinessname'],
        sdchosenserviceid: snapshot['sdchosenserviceid'],
        sdchosenservicename: snapshot['sdchosenservicename'],
        slot: snapshot['slot'],
        timeStamp: snapshot['timeStamp'],
        timeslot: snapshot['timeslot']);
  }

  // Map<String, dynamic> toJson() => {"date": date};
}
