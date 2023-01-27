import 'package:flutter/material.dart';
import '../model/counter_model.dart';
import '../data_source/read_DB.dart';
import 'business_page.dart';

class PersonalCareList extends StatefulWidget {
  final String label;
  final String uid;
  const PersonalCareList({super.key, required this.label, required this.uid});

  @override
  State<PersonalCareList> createState() => _PersonalCareListState();
}

class _PersonalCareListState extends State<PersonalCareList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CounterModel>>(
        stream: ReadDataBase.readbookedcounter(widget.uid, widget.label),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('some error occured'));
          }
          if (snapshot.hasData) {
            final personalcareData = snapshot.data;
            return ListView.builder(
              itemCount: personalcareData!.length,
              itemBuilder: (context, index) {
                return personalcareData[index].isSubbed
                    ? GestureDetector(
                        onTap: () {
                          debugPrint(personalcareData[index].businessid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BusinessPage(
                                          chosenbusiness:
                                              personalcareData[index]
                                                  .businessid)));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                              //businessimage
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    personalcareData[index].businessImage),
                              ),
                              //businessname
                              title: Text(personalcareData[index].businessName),
                              subtitle: Text(
                                  personalcareData[index].businessDescription)),
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
