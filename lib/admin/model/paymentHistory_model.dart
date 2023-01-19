import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String title;
  final String receipt;
  final String date;

  const PaymentModel(
      {required this.title, required this.receipt, required this.date});

  factory PaymentModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PaymentModel(
        title: snapshot['title'],
        receipt: snapshot['receipt'],
        date: snapshot['date']);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "receipt": receipt,
        "date": date,
      };
}
