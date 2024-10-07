import 'package:flutter/material.dart';
import 'package:get/get.dart';
class taxController extends GetxController {
  List<Tax> taxes = [];

  void addtaxes(Tax tax) {
    taxes.add(tax);
    update();
  }

  void removetype(int index) {
    taxes.removeAt(index);
    update();
  }
}

class Tax{
  final String name;
  final String taxrate;
  Tax({
    required this.name,
    required this.taxrate

  });
}