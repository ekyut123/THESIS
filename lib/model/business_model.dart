import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessInfo {
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
  final bool hasGCash;

  BusinessInfo(
      {required this.businessid,
      required this.businessName,
      required this.businessDescription,
      required this.businessType,
      required this.businessImage,
      required this.openingday,
      required this.openinghour,
      required this.closingday,
      required this.closinghour,
      required this.businessaddress,
      required this.hasGCash,
    });

  factory BusinessInfo.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BusinessInfo(
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
        hasGCash: snapshot['hasGCash'],
      );
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
        "hasGCash": hasGCash
      };
}
