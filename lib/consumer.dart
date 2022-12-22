import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/navpages/healthcare_list.dart';
import 'package:flutter_firebase_users/navpages/personalcare_list.dart';
//import 'package:thesisapp_test/widgets/app_short_text.dart';
import 'package:flutter_firebase_users/widgets/navigation_drawer.dart';

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
          return Scaffold(
            drawer: NavigationDrawerWidget(
              consumeremail: email,
              consumerfirstname: firstName,
              consumerlastname: lastName,
              consumerphonenum: phoneNumber
            ),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //categories
                  Container(
                      // alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * .08,
                      child: Align(
                        child: TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            labelPadding: const EdgeInsets.only(left: 10, right: 10),
                            controller: tabController,
                            indicatorSize: TabBarIndicatorSize.label,
                            //isScrollable: true,
                            tabs: const [
                              Tab(text: "Personal Care"),
                              Tab(text: "Health Care"),
                            ]),
                      ),
                    ),
                  //list view
                  Container(
                    height: MediaQuery.of(context).size.height * 1,
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 5),
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        PersonalCareList(label: "Personal Care"),
                        HealthCareList(label: "Health Care")
                      ],
                    )
                  ),
                ],
              ),
            )
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
