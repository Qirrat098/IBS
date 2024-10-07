import 'package:flutter/material.dart';
import 'package:get/get.dart';
class focustypeController extends GetxController {
  List<Focusinfo> focuses = [];

  void addfocuses(Focusinfo focus) {
    focuses.add(focus);
    update();
  }

  void removetype(int index) {
    focuses.removeAt(index);
    update();
  }
}

class Focusinfo {
  final String name;
  final Color  colorcode;
  Focusinfo({
    required this.name,
    required this.colorcode,

  });
}