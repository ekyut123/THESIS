import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_users/model/business_model.dart';
import 'package:flutter_firebase_users/model/service_model.dart';

class BusinessListDB {
  static Stream<List<BusinessInfo>> readbusinessinfo() {
    final businessinfocollection =
        FirebaseFirestore.instance.collection('BusinessList');
    return businessinfocollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BusinessInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<BusinessInfo>> readpersonalcareinfo() {
    final personalcarecollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .where('businessType', isEqualTo: "Personal Care");
    return personalcarecollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BusinessInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<BusinessInfo>> readhealthcareinfo() {
    final healthcarecollection = FirebaseFirestore.instance
        .collection('BusinessList')
        .where('businessType', isEqualTo: "Health Care");
    return healthcarecollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BusinessInfo.fromSnapshot(e)).toList());
  }

  static Stream<List<ServiceInfo>> readserviceinfo() {
    final servicecollection = FirebaseFirestore.instance.collection('Services');
    return servicecollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ServiceInfo.fromSnapshot(e)).toList());
  }
}
