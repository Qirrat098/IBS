import 'package:flutter/material.dart';
import 'package:get/get.dart';
class objectivetypeController extends GetxController {
  List<Objectiveinfo> objectives = [];

  void addobjectives(Objectiveinfo objective) {
    objectives.add(objective);
    update();
  }

  void removetype(int index) {
    objectives.removeAt(index);
    update();
  }
}

class Objectiveinfo{
  final String name;
  final Color  colorcode;
  Objectiveinfo({
    required this.name,
    required this.colorcode,

  });
}