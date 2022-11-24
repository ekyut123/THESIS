import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessInfo {
  final String id;
  final String businessName;
  final String businessDescription;
  final String businessType;
  final String businessImage;

  const BusinessInfo(
      {required this.id,
      required this.businessName,
      required this.businessDescription,
      required this.businessType,
      required this.businessImage});

  factory BusinessInfo.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BusinessInfo(
        id: snapshot['id'],
        businessName: snapshot['businessName'],
        businessDescription: snapshot['businessDescription'],
        businessType: snapshot['businessType'],
        businessImage: snapshot['businessImage']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "businessName": businessName,
        "businessDescription": businessDescription,
        "businessType": businessType,
        "businessImage": businessImage
      };

  // static BusinessInfo fromSnapshot(DocumentSnapshot snap){
  //   BusinessInfo businessinfo = BusinessInfo(
  //     id: snap['id'],
  //     businessName: snap['businessName'],
  //     businessDescription: snap['businessDescription'],
  //     businessType: snap['businessType'],
  //     businessImage: snap['businessImage']
  //   );
  //   return businessinfo;
  // }
}
