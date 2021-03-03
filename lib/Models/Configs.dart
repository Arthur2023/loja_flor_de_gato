import 'package:flutter/material.dart';

class Configs {

  num priceHour;
  num margin;
  Color color;

  Map<String, dynamic> toMap() {
    return {
      "pricehour": priceHour,
      "margin": margin,
      // "color": color,
    };
  }
}