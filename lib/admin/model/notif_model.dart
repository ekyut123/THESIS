import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesModel {
  final String title;
  final String content;
  final String date;

  const MessagesModel({
    required this.title,
    required this.content,
    required this.date
  });

  factory MessagesModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return MessagesModel(
      title: snapshot['title'],
      content: snapshot['content'],
      date: snapshot['date']
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "date": date,
  };
}