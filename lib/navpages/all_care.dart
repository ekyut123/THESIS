import 'package:flutter/material.dart';
import '../model/business_model.dart';
import '../data_source/read_DB.dart';
import 'business_page.dart';

class AllCareList extends StatefulWidget {
  final String uid;
  const AllCareList({super.key, required this.uid});

  @override
  State<AllCareList> createState() => _AllCareListState();
}

class _AllCareListState extends State<AllCareList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BusinessInfo>>(
        stream: ReadDataBase.readbusinessinfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('some error occured'));
          }
          if (snapshot.hasData) {
            final allcarelist = snapshot.data;
            return ListView.builder(
              itemCount: allcarelist!.length,
              itemBuilder: (context, index) {
                return allcarelist[index].isSubbed
                    ? GestureDetector(
                        onTap: () {
                          debugPrint(allcarelist[index].businessid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BusinessPage(
                                          chosenbusiness:
                                              allcarelist[index]
                                                  .businessid)));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                              //businessimage
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    allcarelist[index].businessImage),
                              ),
                              //businessname
                              title: Text(allcarelist[index].businessName),
                              subtitle: Text(
                                  allcarelist[index].businessDescription)),
                        ),
                      )
                    : Container();
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
