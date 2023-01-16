import 'package:flutter/material.dart';
import '../model/counter_model.dart';
import '../data_source/read_DB.dart';
import 'business_page.dart';

class HealthCareList extends StatefulWidget {
  final String label;
  final String uid;
  
  const HealthCareList({
    super.key,
    required this.label,
    required this.uid
  });

  @override
  State<HealthCareList> createState() => _HealthCareListState();
}

class _HealthCareListState extends State<HealthCareList> {
  
  @override
  Widget build(BuildContext context) {
        return StreamBuilder<List<CounterModel>>(
          stream: ReadDataBase.readbookedcounter(widget.uid, widget.label),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('some error occured'));
            }
            if (snapshot.hasData) {
              final healthcareData = snapshot.data;
              return ListView.builder(
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
                                    healthcareData[index].businessid
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
                            NetworkImage(healthcareData[index].businessImage),
                        ),
                        //businessname
                        title: Text(healthcareData[index].businessName),
                        subtitle: Text(healthcareData[index].businessDescription)),
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
