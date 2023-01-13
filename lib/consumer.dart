import 'package:anim_search_bar/anim_search_bar.dart';
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

class _ConsumerPageState extends State<ConsumerPage>
    with TickerProviderStateMixin {
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
          //SearchButton
          // elevation: 0,
          // actions: [
          //   AnimSearchBar(
          //     width: 250,
          //     textController: textController,
          //     onSuffixTap: () {
          //       setState(() {
          //         textController.clear();
          //       });
          //     },
          //     color: Colors.deepOrange[200]!,
          //   ),
          // ],
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
                    children: const [
                      PersonalCareList(label: "Personal Care"),
                      HealthCareList(label: "Health Care")
                    ],
                  )),
            ],
          ),
        ));
  }
}
