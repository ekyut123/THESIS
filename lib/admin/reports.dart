import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_users/admin/data_source/accomplished_DB.dart';
import 'package:flutter_firebase_users/admin/data_source/cancelled_DB.dart';
import 'package:flutter_firebase_users/admin/widget/piechart.dart';
import 'package:intl/intl.dart';

class SummaryReport extends StatefulWidget {
  SummaryReport({
    super.key,
    required this.datetoday,
  });
  String datetoday;
  @override
  State<SummaryReport> createState() => _SummaryReportState();
}

class _SummaryReportState extends State<SummaryReport> {
  TextEditingController dateInput = TextEditingController();

  int DV = 0;
  //day
  String dy = "";
  int intdy = 0;
  //month
  String month = "";
  String nummonth = "";
  int intmonth = 0;
  //year
  String yr = "";
  //get date
  String date = "";
  double totalAcc = 0;
  double totalCanc = 0;
  double dateAcc = 0;
  double dateCanc = 0;
  int price = 0;
  int xprice = 0;
  int dateprice = 0;
  int datexprice = 0;
  @override
  void initState() {
    dateInput.text = "";
    price = 0;
    xprice = 0;
    dateprice = 0;
    datexprice = 0; //set the initial value of text field
    super.initState();
  }

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Summary Reports"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: TextField(
              controller: dateInput,
              //editing controller of this TextField
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () {
                      dateInput.clear();
                      setState(() {
                        date = "";
                      });
                    },
                  ),
                  icon: const Icon(Icons.calendar_today), //icon of text field
                  labelText: "Pick a Date" //label text of field
                  ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  DV = 0;
                  //day
                  dy = DateFormat.d().format(pickedDate);
                  intdy = int.tryParse(dy) ?? DV;
                  //month
                  month = DateFormat.MMM().format(pickedDate);
                  nummonth = DateFormat.M().format(pickedDate);
                  intmonth = int.tryParse(nummonth) ?? DV;
                  //year
                  yr = DateFormat.y().format(pickedDate);
                  //get date
                  date = "$intdy $month, $yr";
                  print(date);
                  setState(() {
                    dateInput.text = date; //set output date to TextField value.
                  });
                } else {}
              },
            )),
          ),
          date != ""
              ? Expanded(
                  child: StreamBuilder(
                    stream: AccomplisedDB.readAccomplisedDate(user!.uid, date),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('some error occured'));
                      }
                      if (snapshot.hasData) {
                        dateprice = 0;
                        totalAcc = snapshot.data!.length.toDouble();
                        snapshot.data!.forEach((x) {
                          datexprice = int.parse(x.price);
                          dateprice = dateprice + datexprice;
                        });
                        return StreamBuilder(
                          stream:
                              CancelledDB.readCancelledDate(user!.uid, date),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              print(snapshot.error);
                              return const Center(
                                  child: Text('some error occured'));
                            }
                            if (snapshot.hasData) {
                              totalCanc = snapshot.data!.length.toDouble();
                              if (totalAcc == 0 && totalCanc == 0) {
                                return const Center(
                                    child: Text(
                                        'You have no accomplished or cancelled bookings'));
                              } else {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 20),
                                      child: Center(
                                          child: Text(
                                        date,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    pieChart(totalAcc, totalCanc),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      'Total Revenue This Day : P${dateprice.toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                );
                              }
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              : Expanded(
                  child: StreamBuilder(
                  stream: AccomplisedDB.readAccomplised(user!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(child: Text('some error occured'));
                    }
                    if (snapshot.hasData) {
                      price = 0;
                      dateAcc = snapshot.data!.length.toDouble();
                      snapshot.data!.forEach((x) {
                        xprice = int.parse(x.price);
                        price = price + xprice;
                      });
                      return StreamBuilder(
                        stream: CancelledDB.readCancelled(user!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Center(
                                child: Text('some error occured'));
                          }
                          if (snapshot.hasData) {
                            dateCanc = snapshot.data!.length.toDouble();
                            if (dateAcc == 0 && dateCanc == 0) {
                              return const Center(
                                  child: Text(
                                      'You have no accomplished or cancelled bookings'));
                            } else {
                              return Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Center(
                                        child: Text(
                                      widget.datetoday,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  pieChart(dateAcc, dateCanc),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Total Revenue : P${price.toString()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              );
                            }
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ))
        ],
      ),
    );
  }
}
