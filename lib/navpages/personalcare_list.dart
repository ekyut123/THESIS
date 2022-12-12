import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/data_source/business_DB.dart';
import 'package:flutter_firebase_users/model/business_model.dart';
import 'business_page.dart';

class PersonalCareList extends StatelessWidget {
  final String label;
  const PersonalCareList({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BusinessInfo>>(
        stream: BusinessListDB.readpersonalcareinfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('some error occured'));
          }
          if (snapshot.hasData) {
            final personalcareData = snapshot.data;
            return ListView.builder(
              itemCount: personalcareData!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    debugPrint(personalcareData[index].businessid);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => BusinessPage(
                                  chosen: personalcareData[index].businessid,
                                  name: personalcareData[index].businessName,
                                  openingday:
                                      personalcareData[index].openingday,
                                  openinghour:
                                      personalcareData[index].openinghour,
                                  closingday:
                                      personalcareData[index].closingday,
                                  closinghour:
                                      personalcareData[index].closinghour,
                                  businessaddress:
                                      personalcareData[index].businessaddress,
                                )));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      //businessimage
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(personalcareData[index].businessImage),
                      ),
                      //businessname
                      title: Text(personalcareData[index].businessName),
                      subtitle:
                          Text(personalcareData[index].businessDescription),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
