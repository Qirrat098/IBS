import 'package:flutter/material.dart';
import 'package:get/get.dart';

class actionstatusController extends GetxController {
  List<AStatus> status= [];

  void addstatus(AStatus state) {
    status.add(state);
    update();
  }


  void removetype(int index) {
    status.removeAt(index);
    update();
  }



}

class AStatus{
  final String name;
  final Color  colorcode;
  final String status;


  AStatus({
    required this.name,
    required this.colorcode,
    required this.status,


  });
}