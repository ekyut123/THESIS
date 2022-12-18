import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/navpages/healthcare_list.dart';
import 'package:flutter_firebase_users/navpages/personalcare_list.dart';
//import 'package:thesisapp_test/widgets/app_short_text.dart';
import 'package:flutter_firebase_users/widgets/navigation_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConsumerPage extends StatefulWidget {
  const ConsumerPage({super.key});

  @override
  State<ConsumerPage> createState() => _ConsumerPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
String email = "";
String firstName = "";
String lastName = "";
String phoneNumber = "";
String uid = "";

class _ConsumerPageState extends State<ConsumerPage>
    with TickerProviderStateMixin {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    User? user = _auth.currentUser!;
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    TextEditingController textController = TextEditingController();
    return Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: SizedBox(
            height: 40.0,
            child: Image.asset('assets/logo.png'),
          ),
          elevation: 0,
          actions: [
            AnimSearchBar(
              width: 250,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
              color: Colors.deepOrange[200]!,
            ),
          ],
        ),
        body: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  email = snapshot.data!['email'];
                  firstName = snapshot.data!['first name'];
                  uid = snapshot.data!['id'];
                  lastName = snapshot.data!['last name'];
                  phoneNumber = snapshot.data!['phone number'];
                  //FOR TESTING. delete mo nalang pag di na kailangan
                  print(email);
                  print(firstName);
                  print(uid);
                  print(lastName);
                  print(phoneNumber);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        //categories
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 60,
                          child: Align(
                            child: TabBar(
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                labelPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                controller: tabController,
                                indicatorSize: TabBarIndicatorSize.label,
                                //isScrollable: true,
                                tabs: const [
                                  Tab(text: "Personal Care"),
                                  Tab(text: "Health Care"),
                                ]),
                          ),
                        ),
                        //firstlayer]
                        Container(
                            height: 600,
                            width: double.maxFinite,
                            margin: const EdgeInsets.only(left: 5),
                            child: TabBarView(
                              controller: tabController,
                              children: const [
                                PersonalCareList(label: "Personal Care"),
                                HealthCareList(label: "Health Care")
                              ],
                            )),
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
              return const CircularProgressIndicator();
            }));
  }
}
