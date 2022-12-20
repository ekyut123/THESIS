import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data_source/business_DB.dart';
import '../model/service_model.dart';
import '../widgets/app_short_text.dart';
import 'booking_page.dart';

class ShowServiceList extends StatelessWidget {
  final double height;
  final String chosenbusinessname;
  final String categorychosen;
  final String chosenbusinessloc;

  const ShowServiceList({
    super.key,
    required this.categorychosen,
    required this.height,
    required this.chosenbusinessname,
    required this.chosenbusinessloc,
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
                        final dt = DateTime.now();
                        final int DV = 0;
                        //day
                        final String dy = DateFormat.d().format(dt);
                        int intdy = int.tryParse(dy) ?? DV;
                        //month
                        final String month = DateFormat.MMM().format(dt);
                        final String nummonth = DateFormat.M().format(dt);
                        final int intmonth = int.tryParse(nummonth) ?? DV;
                        //year
                        final String yr = DateFormat.y().format(dt);
                        //get date tom
                        int intdytom = intdy + 1;
                        final String daytom = intdytom.toString();
                        final String date = "${daytom} ${month}, ${yr}";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => BookingPage(
                                      chosenservicename:
                                          businessservices[index].serviceName,
                                      serviceDescription:
                                          businessservices[index]
                                              .serviceDescription,
                                      serviceimage:
                                          businessservices[index].serviceImage,
                                      serviceprice:
                                          businessservices[index].servicePrice,
                                      chosenbusinessid:
                                          businessservices[index].businessid,
                                      chosenbusinessname: chosenbusinessname,
                                      chosenserviceid:
                                          businessservices[index].serviceid,
                                      categoryName:
                                          businessservices[index].categoryName,
                                      chosenbusinessloc: chosenbusinessloc,
                                      date: date,
                                      intdy: intdytom,
                                      intmonth: intmonth,
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
