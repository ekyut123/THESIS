import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/navpages/category_list.dart';
import '../widgets/app_large_text.dart';
import '../widgets/app_short_text.dart';
import '../widgets/navigation_drawer.dart';

class BusinessPage extends StatelessWidget {
  final String chosen;
  final String name;
  final String openingday;
  final String openinghour;
  final String closingday;
  final String closinghour;
  final String businessaddress;

  const BusinessPage(
      {super.key,
      required this.chosen,
      required this.name,
      required this.openingday,
      required this.openinghour,
      required this.closingday,
      required this.closinghour,
      required this.businessaddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          title: Text(name)),
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
                    AppLargeText(text: name),
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
                      Text("$openingday - $closingday"),
                      Text("$openinghour - $closinghour"),
                    ],
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ShowCategoryList(chosen: chosen),
          ),
        ],
      ),
    );
  }
}
