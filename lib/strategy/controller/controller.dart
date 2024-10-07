

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StrategyController extends GetxController {
  List<Strategy> strategy = [];

  void addStudent(Strategy strat) {
    strategy.add(strat);
    update();
  }


  void removeStudent(int index) {
    strategy.removeAt(index);
    update();
  }



}

class Strategy {
  final String name;
  final String parentStrategy;
  final String team;
  final String plans;
  final String status;
  final String StrategyType;
  final String Timeframe;

  Strategy({
    required this.name,
    required this.parentStrategy,
    required this.team,
    required this.plans,
    required this.status,
    required this.StrategyType,
    required this.Timeframe,

  });
}