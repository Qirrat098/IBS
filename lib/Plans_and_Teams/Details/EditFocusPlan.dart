// lib/widgets/edit_plan_details_dialog.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPlanDetailsDialog extends StatefulWidget {
  final Map<String, String> initialDetail;

  EditPlanDetailsDialog({required this.initialDetail});

  @override
  _EditPlanDetailsDialogState createState() => _EditPlanDetailsDialogState();
}

class _EditPlanDetailsDialogState extends State<EditPlanDetailsDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commencementController = TextEditingController();
  final TextEditingController retirementController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedType;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.initialDetail['focusArea']!;
    commencementController.text = widget.initialDetail['commencement'] ?? '';
    retirementController.text = widget.initialDetail['retirement'] ?? '';
    descriptionController.text = widget.initialDetail['details']!;
    selectedType = widget.initialDetail['type'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Plan Details', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name of Focus Area',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: commencementController,
              decoration: InputDecoration(
                labelText: 'Commencement Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 8),
            TextField(
              controller: retirementController,
              decoration: InputDecoration(
                labelText: 'Retirement Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedType,
                isExpanded: true,
                hint: Text('Select Type'),
                items: {
                  'Management': Colors.blue,
                  'Operational': Colors.green,
                  'Functional': Colors.orange,
                  'No Type': Colors.grey,
                }.entries.map((entry) {
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
                        SizedBox(width: 10),
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
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                commencementController.text.isNotEmpty &&
                retirementController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty &&
                selectedType != null) {
              Navigator.of(context).pop({
                'focusArea': nameController.text,
                'commencement': commencementController.text,
                'retirement': retirementController.text,
                'details': descriptionController.text,
                'type': selectedType!,
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('All fields are required')),
              );
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
