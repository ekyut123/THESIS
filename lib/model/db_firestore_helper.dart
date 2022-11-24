import 'package:cloud_firestore/cloud_firestore.dart';
import 'business_model.dart';

class FirestoreHelper {
  static Stream<List<BusinessInfo>> readbusinessinfo() {
    final businesscollection =
        FirebaseFirestore.instance.collection('BusinessList');
    return businesscollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BusinessInfo.fromSnapshot(e)).toList());
  }
}
