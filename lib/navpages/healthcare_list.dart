import 'package:flutter/material.dart';
import '../data_source/read_DB.dart';
import '../model/business_model.dart';
import 'business_page.dart';

class HealthCareList extends StatelessWidget {
  final String label;

  const HealthCareList({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BusinessInfo>>(
        stream: ReadDataBase.readhealthcareinfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('some error occured'));
          }
          if (snapshot.hasData) {
            final healthcareData = snapshot.data;
            return Expanded(
              child: ListView.builder(
                itemCount: healthcareData!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      debugPrint(healthcareData[index].businessid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => BusinessPage(
                                  chosenbusiness:
                                      healthcareData[index].businessid)));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        //businessimage
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(healthcareData[index].businessImage),
                        ),
                        //businessname
                        title: Text(healthcareData[index].businessName),
                        subtitle:
                            Text(healthcareData[index].businessDescription),
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
