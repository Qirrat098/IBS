// import 'package:cr_calendar_example/res/colors.dart';
// import 'package:cr_calendar_example/utills/constants.dart';
// import 'package:cr_calendar_example/utills/extensions.dart';
import 'package:flutter/material.dart';
import 'package:project_scitforte/settings/extensions.dart';


import '../res/colors.dart';
import '../settings/constants.dart';

class DatePickerTitle extends StatelessWidget {
  const DatePickerTitle({
    required this.date,
    super.key,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          date.format(kMonthFormatWidthYear),
          style: const TextStyle(
            fontSize: 21,
            color: violet,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
