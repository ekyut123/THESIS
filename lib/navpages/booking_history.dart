import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/data_source/read_DB.dart';
import 'package:flutter_firebase_users/model/booking_history.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/app_semi_large_text.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({super.key});

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

final String userid = FirebaseAuth.instance.currentUser!.uid;
final FirebaseAuth _auth = FirebaseAuth.instance;

late String email;
late String firstName;
late String lastName;
late String phoneNumber;
late String docid;
late String sdchosenbusinessid;
late String sdchosenbusinessname;
late String sdchosenserviceid;
late String sdchosenservicename;
late String datetime;
late String date;
late bool rated;
late String ratingstring;

class _BookingHistoryPageState extends State<BookingHistoryPage> {

  double rating = 0;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    User? user = _auth.currentUser!;
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
  }

  void showThankYouDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text(
            'Rating has been submitted!'
          ),
          content: const Text('Thank you so much for rating!'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.deepOrange,),
              child: const Text('Done', style: TextStyle(color: Colors.white)),
              onPressed: (){
                Navigator.of(context).pop();
              })
          ],
        );
      });
  }

  void showDatingDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Rate the Service'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please leave a star rating.'),
              const SizedBox(height: 10),
              buildRating()
            ]
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: const Text('Exit', style: TextStyle(color: Colors.white)),
              onPressed: (){
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: const Text('Rate', style: TextStyle(color: Colors.white)),
              onPressed: (){
                submitRating();
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BookingHistory>>(
      stream: ReadDataBase.readbookinghistory(userid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text('some error occured'));
        }
        if(snapshot.hasData){
          final bookinghistory = snapshot.data;

          return FutureBuilder(
            future: getUser(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                email = snapshot.data!['email'];
                firstName = snapshot.data!['first name'];
                lastName = snapshot.data!['last name'];
                phoneNumber = snapshot.data!['phone number'];

              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Booking History"),
                  ),
                  body: ListView.builder(
                      itemCount: bookinghistory!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white70,
                          child: ListTile(
                            title: AppSemiLargeText(text: bookinghistory[index].sdchosenbusinessname),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(bookinghistory[index].sdchosenservicename),
                                Text(bookinghistory[index].datetime)
                              ],
                            ),
                            trailing: ElevatedButton(
                              child: Text('Submit Rating'),
                              onPressed: bookinghistory[index].rated == true ? null : () {
                                docid = bookinghistory[index].docid;
                                sdchosenbusinessid = bookinghistory[index].sdchosenbusinessid;
                                sdchosenbusinessname = bookinghistory[index].sdchosenbusinessname;
                                sdchosenserviceid = bookinghistory[index].sdchosenserviceid;
                                sdchosenservicename = bookinghistory[index].sdchosenservicename;
                                datetime = bookinghistory[index].datetime;
                                date = bookinghistory[index].date;

                                showDatingDialog();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
              return const Center(child: CircularProgressIndicator()); 
            }
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }

  Widget buildRating() => RatingBar.builder(
    minRating: 1,
    itemBuilder: (context, _) => const Icon(Icons.star),
    itemSize: 30,
    updateOnDrag: true,
    glowColor: Colors.deepOrange,
    onRatingUpdate: (rating){
      setState(() {
        this.rating = rating;
        ratingstring = rating.toString();
      });
    }
  );

  submitRating(){
    var submitRating = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      "docid": docid,
      'sdchosenbusinessid': sdchosenbusinessid,
      'sdchosenbusinessname': sdchosenbusinessname,
      'sdchosenserviceid': sdchosenserviceid,
      'sdchosenservicename': sdchosenservicename,
      'datetime': datetime,
      'date' : date,
      'rating' : ratingstring
    };

    //Update on Firestore Consumer to rated
    FirebaseFirestore.instance
    .collection('Users')
    .doc(userid)
    .collection('Booking History')
    .doc(docid)
    .update({
      'rated': true
    });
    

    //Submit on Firestore Business
    final firestorebusiness = FirebaseFirestore.instance
        .collection('BusinessList')
        .doc(sdchosenbusinessid);
    
    CollectionReference ratingcollection = firestorebusiness.collection('Ratings');
    ratingcollection
    .doc(docid)
    .set(submitRating)
    .then((value) => {
      showThankYouDialog()
    });
  }
}
