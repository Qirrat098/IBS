import 'package:flutter/material.dart';
import 'package:get/get.dart';
class measuretypeController extends GetxController {
  List<Measureinfo> measures = [];

  void addmeasure(Measureinfo measure) {
    measures.add(measure);
    update();
  }

  void removetype(int index) {
    measures.removeAt(index);
    update();
  }
}

class Measureinfo {
  final String name;
  final Color  colorcode;
  Measureinfo({
    required this.name,
    required this.colorcode,

  });
}