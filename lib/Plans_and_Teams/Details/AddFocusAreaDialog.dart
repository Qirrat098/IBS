import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFocusAreaDialog extends StatefulWidget {
  final List<String> focusAreas;

  AddFocusAreaDialog({required this.focusAreas});

  @override
  _AddFocusAreaDialogState createState() => _AddFocusAreaDialogState();
}

class _AddFocusAreaDialogState extends State<AddFocusAreaDialog> {
  TextEditingController strategyController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Create a new focus area',
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select an existing focus area, or create a new one for this plan.",
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,  // Aligns the "Name" label to the right
              children: [
                Text(
                  "Name",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                  children: [
                    Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
              ),
            EditableDropdown(
              options: widget.focusAreas,
              controller: strategyController,
              onItemSelected: (String value) {
                setState(() {
                  strategyController.text = value;
                  errorMessage = null;  // Clear the error message on selection
                });
              },
              onSubmitted: (String value) {
                setState(() {
                  if (value.isNotEmpty && !widget.focusAreas.contains(value)) {
                    widget.focusAreas.add(value);
                  }
                  errorMessage = null;  // Clear the error message on submission
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 70,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFFC01562),
              padding: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(color:Color(0xFFC01562), width: 2.0),
              ),
            ),
            onPressed: () {
              if (strategyController.text.isEmpty) {
                setState(() {
                  errorMessage = 'The name field is required.';
                });
              } else {
                Navigator.of(context).pop(strategyController.text);
              }
            },
            child: Text('Next'),
          ),
        ),
      ],
    );
  }
}

class EditableDropdown extends StatelessWidget {
  final List<String> options;
  final TextEditingController controller;
  final Function(String) onItemSelected;
  final Function(String) onSubmitted;

  EditableDropdown({
    required this.options,
    required this.controller,
    required this.onItemSelected,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[600]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0), // Add horizontal padding
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 3, right: 40 , top:38 ),
                border: InputBorder.none,
              ),
              onSubmitted: onSubmitted,
            ),
          ),
          Positioned(
            top: -5, // Adjust according to your needs
            right: -7,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
              onSelected: onItemSelected,
              itemBuilder: (BuildContext context) {
                return options.map<PopupMenuItem<String>>((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }
}
