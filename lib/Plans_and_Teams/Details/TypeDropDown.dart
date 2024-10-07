import 'package:flutter/material.dart';

class TypeDropdown extends StatefulWidget {
  @override
  _TypeDropdownState createState() => _TypeDropdownState();
}

class _TypeDropdownState extends State<TypeDropdown> {
  String? selectedType;

  final Map<String, Color> typeColors = {
    'Management': Colors.blue,
    'Operational': Colors.green,
    'Functional': Colors.orange,
    'No Type': Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedType,
        isExpanded: true,
        items: typeColors.entries.map((entry) {
          String type = entry.key;
          Color color = entry.value;

          return DropdownMenuItem<String>(
            value: type,
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  color: color,
                ),
                SizedBox(width: 10), // Space between color box and text
                Text(type),
              ],
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedType = newValue;
          });
        },
      ),
    );
  }
}
