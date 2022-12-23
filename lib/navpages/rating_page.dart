import 'package:flutter/material.dart';
import '/data_source/read_DB.dart';
import 'package:flutter_firebase_users/model/rating_model.dart';
import 'package:flutter_firebase_users/widgets/app_semi_large_text.dart';

class RatingPage extends StatefulWidget {
  final String businessid;
  const RatingPage({super.key, required this.businessid});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RatingModel>>(
      stream: ReadDataBase.readrating(widget.businessid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text('some error occured'));
        }
        if(snapshot.hasData){
          final ratingcollection = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Service Ratings'),
            ),
            body: ListView.builder(
              itemCount: ratingcollection!.length,
              itemBuilder: (context, index){
                return Card(
                  color: Colors.white70,
                  child: ListTile(
                    title: AppSemiLargeText(text: ratingcollection[index].sdchosenservicename),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${ratingcollection[index].firstName} ${ratingcollection[index].lastName}'),
                        Text('Rating: ${ratingcollection[index].rating}')
                      ],
                    ),
                  ),
                );
              }
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
