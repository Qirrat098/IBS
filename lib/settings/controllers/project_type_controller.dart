import 'package:flutter/material.dart';
import 'package:get/get.dart';
class projecttypeController extends GetxController {
  List<Projectinfo> projects = [];

  void addprojects(Projectinfo project) {
   projects.add(project);
    update();
  }

  void removetype(int index) {
   projects.removeAt(index);
    update();
  }
}

class Projectinfo{
  final String name;
  final Color  colorcode;
  Projectinfo({
    required this.name,
    required this.colorcode,

  });
}