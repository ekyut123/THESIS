import 'package:flutter/material.dart';
import 'paymentoptions.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Submit Receipt'),
        icon: const Icon(Icons.file_upload),
        backgroundColor: Colors.deepOrange,
      ),
      appBar: AppBar(
        title: const Text('Payment History'),
        actions: [
          Tooltip(
            message: 'Payment Options',
            child: IconButton(
              icon: const Icon(Icons.payment),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AdminPaymentOption()
                ));
              }
            ),
          )
        ],
      ),
    );
  }
}