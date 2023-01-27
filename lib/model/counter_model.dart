import 'package:cloud_firestore/cloud_firestore.dart';

class CounterModel {
  final String businessid;
  final String businessName;
  final String businessDescription;
  final String businessType;
  final String businessImage;
  final String openingday;
  final String openinghour;
  final String closingday;
  final String closinghour;
  final String businessaddress;
  final int counter;
  final bool isSubbed;

  const CounterModel(
      {required this.isSubbed,
      required this.businessid,
      required this.businessName,
      required this.businessDescription,
      required this.businessType,
      required this.businessImage,
      required this.openingday,
      required this.openinghour,
      required this.closingday,
      required this.closinghour,
      required this.businessaddress,
      required this.counter});

  factory CounterModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CounterModel(
        isSubbed: snapshot['isSubbed'],
        businessid: snapshot['businessid'],
        businessName: snapshot['businessName'],
        businessDescription: snapshot['businessDescription'],
        businessType: snapshot['businessType'],
        businessImage: snapshot['businessImage'],
        openingday: snapshot['opening day'],
        openinghour: snapshot['opening hour'],
        closingday: snapshot['closing day'],
        closinghour: snapshot['closing hour'],
        businessaddress: snapshot['business address'],
        counter: snapshot['counter']);
  }

  Map<String, dynamic> toJson() => {
        "businessid": businessid,
        "businessName": businessName,
        "businessDescription": businessDescription,
        "businessType": businessType,
        "businessImage": businessImage,
        "opening day": openingday,
        "opening hour": openinghour,
        "closing day": closingday,
        "closing hour": closinghour,
        "business address": businessaddress,
        "counter": counter
      };
}
