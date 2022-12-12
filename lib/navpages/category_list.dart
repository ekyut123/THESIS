import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/data_source/business_DB.dart';
import 'package:flutter_firebase_users/model/service_model.dart';
import 'package:flutter_firebase_users/navpages/service_list.dart';
import '../widgets/app_semi_large_text.dart';

class ShowCategoryList extends StatelessWidget {
  final String chosen;
  const ShowCategoryList({super.key, required this.chosen});

  @override
  Widget build(BuildContext context) {
    String cat;
    final double height = MediaQuery.of(context).size.height;
    final List<ServiceInfo> businessservices = [];
    return StreamBuilder<List<ServiceInfo>>(
        stream: BusinessListDB.readserviceinfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('some error occured'));
          }
          if (snapshot.hasData) {
            final categoryData = snapshot.data;
            for (var category in categoryData!) {
              bool isAdded = false;
              if (category.businessid == chosen) {
                if (businessservices.isEmpty) {
                  businessservices.add(category);
                } else {
                  for (int i = 0; i < businessservices.length; i++) {
                    if (businessservices[i].categoryName ==
                        category.categoryName) {
                      isAdded = true;
                    }
                  }
                  if (isAdded) {
                    continue;
                  } else {
                    businessservices.add(category);
                  }
                }
              }
            }
            return ListView.builder(
                itemCount: businessservices.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: AppSemiLargeText(
                            text: businessservices[index].categoryName),
                      ),
                      const SizedBox(height: 10),
                      ShowServiceList(
                          categorychosen: businessservices[index].categoryName,
                          height: height * .3)
                    ],
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
