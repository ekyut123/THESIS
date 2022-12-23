import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/app_large_text.dart';
import '../widgets/app_short_text.dart';
import '../widgets/navigation_drawer.dart';
import 'category_list.dart';
import '../navpages/rating_page.dart';

class BusinessPage extends StatelessWidget {
  final String chosenbusiness;

  const BusinessPage({
    super.key,
    required this.chosenbusiness,
  });

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    String email = "";
    String firstName = "";
    String lastName = "";
    String phoneNumber = "";

    Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    User? user = _auth.currentUser!;
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
  }

    String businessaddress = "";
    String businessName = "";
    String closingday = "";
    String closinghour = "";
    String openingday = "";
    String openinghour = "";
    String businessImage = "";

    Future<DocumentSnapshot<Map<String, dynamic>>> readbusinessinfo(String businessid) async{
      return await FirebaseFirestore.instance.collection('BusinessList').doc(businessid).get();
    }

    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('some error occured'));
        }
        if(snapshot.hasData){
          email = snapshot.data!['email'];
          firstName = snapshot.data!['first name'];
          lastName = snapshot.data!['last name'];
          phoneNumber = snapshot.data!['phone number'];

          return FutureBuilder(
            future: readbusinessinfo(chosenbusiness),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('some error occured'));
              }
              if(snapshot.hasData){
                businessImage = snapshot.data!['businessImage'];
                businessaddress = snapshot.data!['business address'];
                businessName = snapshot.data!['businessName'];
                closingday = snapshot.data!['closing day'];
                closinghour = snapshot.data!['closing hour'];
                openingday = snapshot.data!['opening day'];
                openinghour = snapshot.data!['opening hour'];
                
                return Scaffold(
                  drawer: const NavigationDrawerWidget(),
                  appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: Colors.deepOrange,
                    title: Text(businessName),
                    actions: [
                      Tooltip(
                        message: 'Ratings ',
                        child: IconButton(
                          icon: const Icon(Icons.feedback_rounded),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RatingPage(businessid: chosenbusiness,
                            )
                          )
                        );
                        }),
                      )
                    ],
                  ),
                  body: Column(
                  children: [
                    Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(color: Colors.grey[100]),
                        ),
                    Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(text: businessName),
                                  const SizedBox(height: 5),
                                  AppShortText(text: businessaddress, color: Colors.black)
                                ],
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding: const EdgeInsets.only(right: 15, top: 20),
                                alignment: Alignment.topRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("${openingday} - ${closingday}"),
                                    Text("${openinghour} - ${closinghour}"),
                                  ],
                                )),
                          ],
                        ),
                    const SizedBox(height: 10),
                    Expanded(
                          child: ShowCategoryList(
                            chosenbusinessid: chosenbusiness,
                          ),
                        ),
                      ],
                  )
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
}
