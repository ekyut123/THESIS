import 'package:cloud_firestore/cloud_firestore.dart';

class AccomplisedInfo {
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
      timeslot,
      docid;
  final int slot, timeStamp;

  const AccomplisedInfo(
      {required this.consumeremail,
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
      required this.timeslot,
      required this.docid});

  factory AccomplisedInfo.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AccomplisedInfo(
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
        timeslot: snapshot['timeslot'],
        docid: snapshot['docid']);
  }

  // Map<String, dynamic> toJson() => {"date": date};
}
