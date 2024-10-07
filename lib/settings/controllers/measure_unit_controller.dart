import 'package:flutter/material.dart';
import 'package:get/get.dart';
class measureunitController extends GetxController {
  List<Measureunit> units = [];

  void addunits(Measureunit unit) {
    units.add(unit);
    update();
  }

  void removetype(int index) {
    units.removeAt(index);
    update();
  }
}

class Measureunit{
  final String name;
  final String unit;
  Measureunit({
    required this.name,
   required this.unit

  });
}