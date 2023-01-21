import 'package:flutter/material.dart';

ListTile bookingtile(String title, String name) {
  return ListTile(
    title: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        '$title : ',
        textAlign: TextAlign.center,
      ),
      Text(
        name,
        textAlign: TextAlign.center,
      )
    ]),
  );
}
