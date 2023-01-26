import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/admin/data_source/paymentHistory_DB.dart';
import 'package:flutter_firebase_users/admin/model/paymentHistory_model.dart';
import 'package:flutter_firebase_users/admin/widget/app_minus_large_text.dart';
import 'package:flutter_firebase_users/admin/widget/validtext.dart';
import '../widgets/app_semi_large_text.dart';
import '../widgets/app_short_text.dart';

//main payment history confirmreceipt paymenthistorymodel paymenthistorydb yaml
class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

late String title;
late String receipt;
late String date;

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    void showPaymentDetails() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title.toUpperCase(),
                  style: const TextStyle(color: Colors.deepOrange)),
              content: Image.network(receipt),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    child: const Text(
                      "Exit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(const PaymentHistoryPage());
                    })
              ],
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Subscription History'),
        ),
        body: StreamBuilder<List<PaymentModel>>(
          stream: PaymentHistoryDB.readpaymenthistory(user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(child: Text('some error occured'));
            }
            if (snapshot.hasData) {
              final history = snapshot.data;
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: history!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white70,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppMinusLargeText(text: history[index].title),
                              ValidText(
                                  text: 'Valid Until: ${history[index].date}'),
                            ],
                          ),
                          subtitle: const Text('Click to view receipt'),
                          onTap: () {
                            title = history[index].title;
                            receipt = history[index].receipt;
                            date = history[index].date;

                            showPaymentDetails();
                          },
                        ),
                      );
                    });
              } else {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'You have not sent a receipt or your receipt is being processed',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
