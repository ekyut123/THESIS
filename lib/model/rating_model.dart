import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String sdchosenbusinessid;
  final String sdchosenbusinessname;
  final String sdchosenserviceid;
  final String sdchosenservicename;
  final String date;
  final String datetime;
  final String docid;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String rating;

  const RatingModel({
    required this.sdchosenbusinessid,
    required this.sdchosenbusinessname,
    required this.sdchosenserviceid,
    required this.sdchosenservicename,
    required this.date,
    required this.datetime,
    required this.docid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.rating
  });

  factory RatingModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return RatingModel(
      sdchosenbusinessid: snapshot['sdchosenbusinessid'],
      sdchosenbusinessname: snapshot['sdchosenbusinessname'],
      sdchosenserviceid: snapshot['sdchosenserviceid'],
      sdchosenservicename: snapshot['sdchosenservicename'],
      date: snapshot['date'],
      datetime: snapshot['datetime'],
      docid: snapshot['docid'],
      email: snapshot['email'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      phoneNumber: snapshot['phoneNumber'],
      rating: snapshot['rating']
    );
  }

  Map<String, dynamic> toJson() => {
      'sdchosenbusinessid': sdchosenbusinessid,
      'sdchosenbusinessname': sdchosenbusinessname,
      'sdchosenserviceid': sdchosenserviceid,
      'sdchosenservicename': sdchosenservicename,
      'date': date,
      'datetime': datetime,
      'docid': docid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'rating': rating
      };
}
