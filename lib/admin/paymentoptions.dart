import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPaymentOption extends StatefulWidget {
  const AdminPaymentOption({super.key});

  @override
  State<AdminPaymentOption> createState() => _PaymentOptionPageState();
}

late String picture;

class _PaymentOptionPageState extends State<AdminPaymentOption> {

  CollectionReference qr = FirebaseFirestore.instance.collection('Admin Payment Option');
  
  @override
  Widget build(BuildContext context) {

    void showGCashQR(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return FutureBuilder(
            future: qr.doc('N9ridEkbcR3mv5cw3WGA').get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.hasData){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                picture = data['picture'];

                return AlertDialog(
                title: const Text('QR Code',
                  style: TextStyle(color: Colors.deepOrange)
                  ),
                content: Image.network(picture),
                actions: [
                  TextButton(style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text(
                    "Exit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(const AdminPaymentOption());
                    }
                  )
                ],
              );
              }
              return const Center(child: CircularProgressIndicator());
            }
          );
        });
    }

    void showBPIQR(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return FutureBuilder(
            future: qr.doc('jtBLhIV3IRcQlLQsL6Cj').get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.hasData){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                picture = data['picture'];

                return AlertDialog(
                title: const Text('QR Code',
                  style: TextStyle(color: Colors.deepOrange)
                  ),
                content: Image.network(picture),
                actions: [
                  TextButton(style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text(
                    "Exit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(const AdminPaymentOption());
                    }
                  )
                ],
              );
              }
              return const Center(child: CircularProgressIndicator());
            }
          );
        });
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.payment,
                size: 100,
                color: Colors.deepOrange),
                Text(
                  "Payment Options",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                  ),
                )
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "1. GCASH",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextButton(
                    onPressed: () {
                      showGCashQR();
                    },
                    child: const Text('QR Code')
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text('Account Name:  ',
                    style: TextStyle(
                      fontSize: 15
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 70),
                  child: Text('SRVCS Company',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 50, top: 15),
                  child: Text('Account Number:  ',
                    style: TextStyle(
                      fontSize: 15
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 70, top: 15),
                  child: Text('09053730234',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )),
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
                      fontSize: 25,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 25),
                  child: TextButton(
                    onPressed: () {
                      showBPIQR();
                    },
                    child: const Text('QR Code')
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text('Account Name:  ',
                    style: TextStyle(
                      fontSize: 15
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 70),
                  child: Text('SRVCS Company',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 50, top: 15),
                  child: Text('Account Number:  ',
                    style: TextStyle(
                      fontSize: 15
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 70, top: 15),
                  child: Text('08812345678',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ],
            ),
        ]
        ),
      ),
    );
  }
}