import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceInfo {
  final String businessid;
  final String categoryName;
  final String serviceid;
  final String serviceName;
  final String servicePrice;
  final String serviceImage;
  final String serviceDescription;

  const ServiceInfo(
      {required this.businessid,
      required this.categoryName,
      required this.serviceid,
      required this.serviceName,
      required this.servicePrice,
      required this.serviceImage,
      required this.serviceDescription});

  factory ServiceInfo.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ServiceInfo(
        businessid: snapshot['businessid'],
        categoryName: snapshot['categoryName'],
        serviceid: snapshot['serviceid'],
        serviceName: snapshot['serviceName'],
        servicePrice: snapshot['servicePrice'],
        serviceImage: snapshot['serviceImage'],
        serviceDescription: snapshot['serviceDescription']);
  }

  get categoryid => null;

  Map<String, dynamic> toJson() => {
        "businessid": businessid,
        "categoryName": categoryName,
        "serviceid": serviceid,
        "serviceName": serviceName,
        "servicePrice": serviceName,
        "serviceImage": serviceImage,
        "serviceDescription": serviceDescription
      };
}
