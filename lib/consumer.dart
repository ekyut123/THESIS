import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/navpages/healthcare_list.dart';
import 'package:flutter_firebase_users/navpages/personalcare_list.dart';
import 'package:flutter_firebase_users/searchdelegate.dart';
//import 'package:thesisapp_test/widgets/app_short_text.dart';
import 'package:flutter_firebase_users/widgets/navigation_drawer.dart';

//added search
class ConsumerPage extends StatefulWidget {
  const ConsumerPage({super.key});

  @override
  State<ConsumerPage> createState() => _ConsumerPageState();
}

final String userid = FirebaseAuth.instance.currentUser!.uid;
final FirebaseAuth _auth = FirebaseAuth.instance;

late String email;
late String firstName;
late String lastName;
late String phoneNumber;

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
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
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
              //firstlayer]
              Container(
                  height: 600,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 5),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      PersonalCareList(label: "Personal Care", uid: userid),
                      HealthCareList(label: "Health Care", uid: userid)
                    ],
                  )),
            ],
          ),
        ));
  }
}
