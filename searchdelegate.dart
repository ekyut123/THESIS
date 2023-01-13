import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/data_source/read_DB.dart';

import 'model/business_model.dart';
import 'navpages/business_page.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

//added search
  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // return StreamBuilder<List<BusinessInfo>>(
    //   stream: ReadDataBase.readqueryinfo(query),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //     if (snapshot.hasError) {
    //       return const Center(child: Text('some error occured'));
    //     }
    //     if (snapshot.hasData) {
    //       final queryData = snapshot.data;
    //       return ListView.builder(
    //         itemCount: queryData!.length,
    //         itemBuilder: (context, index) {
    //           return GestureDetector(
    //             onTap: () {
    //               debugPrint(queryData[index].businessid);
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (BuildContext context) => BusinessPage(
    //                           chosenbusiness: queryData[index].businessid)));
    //             },
    //             child: Container(
    //               margin: const EdgeInsets.symmetric(vertical: 5),
    //               child: ListTile(
    //                   //businessimage
    //                   leading: CircleAvatar(
    //                     radius: 30,
    //                     backgroundImage:
    //                         NetworkImage(queryData[index].businessImage),
    //                   ),
    //                   //businessname
    //                   title: Text(queryData[index].businessName),
    //                   subtitle: Text(queryData[index].businessDescription)),
    //             ),
    //           );
    //         },
    //       );
    //     }
    //     return const Center(child: CircularProgressIndicator());
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<BusinessInfo>>(
      stream: ReadDataBase.readqueryinfo(query.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('some error occured'));
        }
        if (snapshot.hasData) {
          final businessdata = snapshot.data;
          if (businessdata!.isEmpty) {
            return const ListTile(
              title: Center(
                child: Text(
                  "No business found with searched name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: businessdata.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  debugPrint(businessdata[index].businessid);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BusinessPage(
                              chosenbusiness: businessdata[index].businessid)));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                      //businessimage
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(businessdata[index].businessImage),
                      ),
                      //businessname
                      title: Text(businessdata[index].businessName),
                      subtitle: Text(businessdata[index].businessDescription)),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
