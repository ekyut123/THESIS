import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/admin/confirmReceipt.dart';
import 'package:flutter_firebase_users/admin/payment_history.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

late String picture;

class _PaymentPageState extends State<PaymentPage> {
  CollectionReference qr =
      FirebaseFirestore.instance.collection('Admin Payment Option');

  PlatformFile? pickedFile;
  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'jpg',
      'jpeg',
      'png',
      'jfif',
    ]);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  String bid = '';
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("BusinessList")
        .doc(user!.uid)
        .get()
        .then((value) {
      var data = value.data() as Map;
      bid = data['businessName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    void showGCashQR() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return FutureBuilder(
                future: qr.doc('N9ridEkbcR3mv5cw3WGA').get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    picture = data['picture'];

                    return AlertDialog(
                      title: const Text('QR Code',
                          style: TextStyle(color: Colors.deepOrange)),
                      content: Image.network(picture),
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
                              Navigator.of(context).pop(const PaymentPage());
                            })
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                });
          });
    }

    void showBPIQR() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return FutureBuilder(
                future: qr.doc('jtBLhIV3IRcQlLQsL6Cj').get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    picture = data['picture'];

                    return AlertDialog(
                      title: const Text('QR Code',
                          style: TextStyle(color: Colors.deepOrange)),
                      content: Image.network(picture),
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
                              Navigator.of(context).pop(const PaymentPage());
                            })
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                });
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: pickedFile != null
          ? ConfirmReceipt(
              filepath: pickedFile!.path!,
              businessname: bid,
              userUid: user!.uid,
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                        '*For subscription, please refer to the following payment options and submit the receipt of payment for validation purposes.*',
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 15),
                        textAlign: TextAlign.justify),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.payment,
                            size: 100, color: Colors.deepOrange),
                        Text(
                          "Payment Options",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "1. GCASH",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: ElevatedButton(
                            onPressed: () {
                              showGCashQR();
                            },
                            child: const Text('QR Code')),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Text('Account Name:  ',
                            style: TextStyle(fontSize: 15)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 70),
                        child: Text('SRVCS Company',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 50, top: 15),
                        child: Text('Account Number:  ',
                            style: TextStyle(fontSize: 15)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 70, top: 15),
                        child: Text('09053730234',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 25),
                        child: Text(
                          "2. BPI",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 25),
                        child: ElevatedButton(
                            onPressed: () {
                              showBPIQR();
                            },
                            child: const Text('QR Code')),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Text('Account Name:  ',
                            style: TextStyle(fontSize: 15)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 70),
                        child: Text('SRVCS Company',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 50, top: 15),
                        child: Text('Account Number:  ',
                            style: TextStyle(fontSize: 15)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 70, top: 15),
                        child: Text('08812345678',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const PaymentHistoryPage()));
                            },
                            child: const Text('Subscription History')),
                        ElevatedButton(
                            onPressed: () {
                              selectFile();
                            },
                            child: const Text('Upload Receipt'))
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
