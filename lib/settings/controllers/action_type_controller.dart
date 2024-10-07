import 'package:flutter/material.dart';
import 'package:get/get.dart';
class actiontypeController extends GetxController {
  List<Actioninfo> actions = [];

  void addaction(Actioninfo action) {
    actions.add(action);
    update();
  }

  void removetype(int index) {
    actions.removeAt(index);
    update();
  }
}

class Actioninfo {
  final String name;
  final Color  colorcode;
  Actioninfo({
    required this.name,
    required this.colorcode,

  });
}