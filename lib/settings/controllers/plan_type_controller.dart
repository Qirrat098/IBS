import 'package:flutter/material.dart';
import 'package:get/get.dart';
class plantypeController extends GetxController {
  List<Plan> plans = [];

  void addtype(Plan type) {
    plans.add(type);
    update();
  }

  void removetype(int index) {
    plans.removeAt(index);
    update();
  }
}

class Plan {
  final String name;
  final Color  colorcode;
  Plan({
    required this.name,
    required this.colorcode,

  });
}