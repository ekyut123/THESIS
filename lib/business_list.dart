import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/pages/businesspages/nailaholics_page.dart';
import 'model/business_model.dart';
import 'model/db_firestore_helper.dart';

class ShowBusinessList extends StatelessWidget {
  const ShowBusinessList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BusinessInfo>>(
        stream: FirestoreHelper.readbusinessinfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('some error occured'));
          }
          if (snapshot.hasData) {
            final businessData = snapshot.data;
            return Expanded(
              child: ListView.builder(
                itemCount: businessData!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      debugPrint(businessData[index].id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NailaholicsPage(context, 0)));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        //businessimage
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(businessData[index].businessImage),
                        ),
                        //businessname
                        title: Text(businessData[index].businessName),
                        subtitle: Text(businessData[index].businessDescription),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
