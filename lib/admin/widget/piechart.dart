import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

PieChart pieChart(double acc, double canc) {
  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];
  Map<String, double> totaldataMap = {
    "Accomplished": acc,
    "Cancelled": canc,
  };
  return PieChart(
    dataMap: totaldataMap,
    colorList: colorList,
  );
}
