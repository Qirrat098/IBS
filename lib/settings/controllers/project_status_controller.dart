import 'package:flutter/material.dart';
import 'package:get/get.dart';

class projectstatusController extends GetxController {
  List<PStatus> projects= [];

  void addproject(PStatus project) {
    projects.add(project);
    update();
  }


  void removetype(int index) {
    projects.removeAt(index);
    update();
  }



}

class PStatus{
  final String name;
  final Color  colorcode;
  final String status;


  PStatus({
    required this.name,
    required this.colorcode,
    required this.status,


  });
}