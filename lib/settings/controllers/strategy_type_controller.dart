import 'package:flutter/material.dart';
import 'package:get/get.dart';

class typeController extends GetxController {
  List<Type> types = [];

  void addtype(Type type) {
    types.add(type);
    update();
  }

  void removetype(int index) {
    types.removeAt(index);
    update();
  }
}

class Type {
  final String name;
  final Color  colorcode;
  Type({
    required this.name,
    required this.colorcode,

  });
}