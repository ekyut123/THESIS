import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ValidText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  ValidText(
      {Key? key,
      this.size = 12,
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
