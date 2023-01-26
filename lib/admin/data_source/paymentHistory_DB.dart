import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_users/admin/model/paymentHistory_model.dart';


class PaymentHistoryDB {
  static Stream<List<PaymentModel>> readpaymenthistory(String businessid) {
    final paymentcollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(businessid)
        .collection('Payment History')
        .orderBy('date', descending: true);
    return paymentcollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => PaymentModel.fromSnapshot(e)).toList());
  }
}
