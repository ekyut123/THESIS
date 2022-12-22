import 'package:flutter/material.dart';
import '../data_source/read_DB.dart';
import '../model/business_model.dart';
import 'business_page.dart';

class PersonalCareList extends StatelessWidget {
  final String label;
  const PersonalCareList({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BusinessInfo>>(
      stream: ReadDataBase.readpersonalcareinfo(),
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
                                chosenbusiness:
                                personalcareData[index].businessid
                          )
                      )
                  );
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
                    subtitle: Text(personalcareData[index].businessDescription)),
                  ),
                );
              },
            );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
