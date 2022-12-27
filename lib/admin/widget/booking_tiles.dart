import 'package:flutter/material.dart';

ListTile bookingtile(String title, String name) {
  return ListTile(
    title: Column(children: [Text('$title : '), Text(name)]),
  );
}
