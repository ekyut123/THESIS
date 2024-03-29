import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppMinusLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppMinusLargeText(
      {Key? key,
      this.size = 17,
      required this.text,
      this.color = Colors.deepOrange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w800),
    );
  }
}
