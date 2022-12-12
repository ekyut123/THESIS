import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/data_source/business_DB.dart';
import 'package:flutter_firebase_users/model/service_model.dart';
import 'package:flutter_firebase_users/navpages/booking_page.dart';
import '../widgets/app_short_text.dart';

class ShowServiceList extends StatelessWidget {
  final double height;
  final String categorychosen;
  const ShowServiceList({
    super.key,
    required this.categorychosen,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final businessservices = [];
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
            final serviceData = snapshot.data;

            for (dynamic i = 0; i < serviceData?.length; i++) {
              if (serviceData?[i].categoryName == categorychosen) {
                businessservices.add(serviceData?[i]);
              }
            }
            return SizedBox(
              height: height,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: businessservices.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        debugPrint(businessservices[index].serviceid);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => BookingPage(
                                      name: businessservices[index].serviceName,
                                      serviceimage:
                                          businessservices[index].serviceImage,
                                      serviceprice:
                                          businessservices[index].servicePrice,
                                      serviceDescription:
                                          businessservices[index]
                                              .serviceDescription,
                                    )));
                      },
                      child: Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 20, top: 10),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        businessservices[index].serviceImage),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, right: 20),
                              child: AppShortText(
                                  text: businessservices[index].serviceName,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
