// // ignore_for_file: unnecessary_new
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_users/navpages/booking_page.dart';
// import 'package:flutter_firebase_users/data_source/booking_DB.dart';
// import 'package:flutter_firebase_users/model/booking_model.dart';

// // ignore: camel_case_types, must_be_immutable
// class ActiveBooking extends StatefulWidget {
//   const ActiveBooking({Key? key}) : super(key: key);

//   @override
//   State<ActiveBooking> createState() => _ActiveBooking();
// }

// class _ActiveBooking extends State<ActiveBooking> {
//   void showAlertDialog(context, index) {
//     // set up the buttons
//     Widget cancelButton = TextButton(
//       style: TextButton.styleFrom(
//         backgroundColor: Colors.deepOrange,
//       ),
//       child: const Text(
//         "Yes",
//         style: TextStyle(color: Colors.white),
//       ),
//       onPressed: () {
//         Navigator.of(context).pop();
//         setState(() {
//            //booking.removeAt(index);
//         });
//       },
//     );
//     Widget continueButton = TextButton(
//       style: TextButton.styleFrom(
//         backgroundColor: Colors.deepOrange,
//       ),
//       child: const Text(
//         "No",
//         style: TextStyle(color: Colors.white),
//       ),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: const Text(
//         "Cancellation",
//         style: TextStyle(color: Colors.deepOrange),
//       ),
//       content: const Text("Are you sure that you want to cancel your booking?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<BookingInfo>>(
//         stream: BookingDB.readbookinginfo(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Center(child: Text('some error occured'));
//           }
//           if (snapshot.hasData) {
//             final booking = snapshot.data;

//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text("Active Booking"),
//               ),
//               body: ListView.builder(
//                   itemCount: booking!.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       color: Colors.deepOrange,
//                       child: ListTile(
//                         title: Text(booking[index].date),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             ElevatedButton(
//                                 onPressed: () {
//                                   showAlertDialog(context, index);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors
//                                         .white, //change for background color of the button
//                                     foregroundColor: Colors.black),
//                                 child: const Text(
//                                     'Cancel') //change for the text color of button
//                                 ),
//                             const SizedBox(width: 8),
//                             ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               const BookingPage(
//                                                 name: '',
//                                                 serviceDescription: '',
//                                                 serviceimage: '',
//                                                 serviceprice: '',
//                                               )));
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors
//                                         .white, //change for background color of the button
//                                     foregroundColor: Colors.black),
//                                 child: const Text(
//                                     'Reschedule') //change for the text color of button
//                                 ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         });
//   }
// }
