import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppSemiLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppSemiLargeText(
      {Key? key,
      this.size = 15,
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
