import 'package:get/get.dart';

class Elementgrp {
  final String group;
  final String name;

  Elementgrp({required this.group, required this.name});
}

class GroupListController extends GetxController {
  final RxList<Elementgrp> _elements = [
    Elementgrp(group: 'Team A', name: 'john'),

  ].obs;

  List<Elementgrp> get elements => _elements.value;

  void addElement(String group, String name) {
    _elements.add(Elementgrp(group: group, name: name));
  }

  void removeElement(int index) {
    _elements.removeAt(index);
  }
}