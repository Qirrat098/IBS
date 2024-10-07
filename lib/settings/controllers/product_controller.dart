import 'package:get/get.dart';

class Productgrp {
  final String group;
  final String name;

  Productgrp({required this.group, required this.name});
}

class productgroupListScreen extends GetxController {
  final RxList<Productgrp> _products = [
    Productgrp(group: 'Team A', name: 'sidrah'),

  ].obs;

  List<Productgrp> get products => _products.value;

  void addElement(String group, String name) {
    _products.add(Productgrp(group: group, name: name));
  }

  void removeElement(int index) {
    _products.removeAt(index);
  }
}