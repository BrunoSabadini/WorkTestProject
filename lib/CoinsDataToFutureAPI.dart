import 'package:flutter/material.dart';

class Coins {
  String abreviation;
  String name;
  double variation = 8.4;
  IconData icon;
  bool animate = true;
  Coins(
      {Key? key,
      required this.abreviation,
      required this.name,
      required this.icon});
}

class DetailPage {
  String coinName;
  double value;
  double minValue;
  double maxValue;
  double capMercado;
  DetailPage({
    Key? key,
    required this.coinName,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.capMercado,
  });
}
